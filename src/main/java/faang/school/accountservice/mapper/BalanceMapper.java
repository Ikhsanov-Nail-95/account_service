package faang.school.accountservice.mapper;

import faang.school.accountservice.dto.BalanceDto;
import faang.school.accountservice.model.Balance;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BalanceMapper {

    @Mapping(source = "account.id", target = "accountId")
    BalanceDto toDto(Balance balance);

    @Mapping(target = "account", ignore = true)
    Balance toEntity(BalanceDto balanceDto);
}
