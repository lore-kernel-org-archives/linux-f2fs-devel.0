Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E8C4167D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Nov 2023 15:17:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r0Npx-0005wZ-Qf;
	Tue, 07 Nov 2023 15:17:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r0Npw-0005wT-7F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 15:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iwivhnlv0jOPHkBGHXEGyqDw1bqcXWL1rsgXjzVe2XM=; b=DB62AVH82uhP+dPw9cpEDAzBZ2
 9CnFzwedALpzZf9BkMxnvQihkYqQwYXk+4mUhfiuO9SD/YTfWrDY0CfFHJsBzMU0216l7KCIvPBxX
 sDD2uRFgrNm2LUjDaIlCWG5b+6DO5qMLEHk48tXmbXw+CugTOr+o48QdH6xOXW7JoBmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Iwivhnlv0jOPHkBGHXEGyqDw1bqcXWL1rsgXjzVe2XM=; b=HCdYRVPmQVmYgaOlSSL2nDlyD2
 lmUNCcG8RYRFCEjn/Tog25x2KbuqSd8RHVdCZU0KGV4l+QoYai3+QxHXlIFnhv3TPUBFir8bKYFIO
 wFX6HhSLGDhwxIoxGIl+W19wSaVaBGQpHiIbT55XB+5/qnsbtUciUZZCQRYv6jpRqW1c=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r0Npv-00ATR2-Df for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 15:17:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 336DECE0E92
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Nov 2023 15:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4AFC433C7;
 Tue,  7 Nov 2023 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699370258;
 bh=UxL35KjJQ/twQVAUT2tkNwtkMZEf2lQpswfQ1wsLrgg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=m5MIQM1O3IibI6393f+ZQSXm52n2DNDN030z13SkAtyHDE92rBR+SXURgv1pXEs8u
 Wjnz/HvlMsGh2+al/Vwi/OFP68eRK7r9AzPAca2HTt9zlOo7Rz5TRXaUPeY7OPTOR0
 LcRzU9LJEErkqr36S7YG3S+K4c1SyCXAM8BTm2Q+D6v3azO1ih2EwlJnRbx6X38VhT
 sZKEaICHnd1NSqv6aKzvX+Df87F1nSb0ImCwbZSJqpnax7EsZQGyPdiLMis4XUZr9I
 86N426aTaFYNpEBIKActrZxEaoYEymsS8Ui364eh6vYRKnN0AEf/mkpHW+bZ0sP/AK
 SPcl3T68j5WXQ==
Message-ID: <182aa8bc-6825-57ee-f5f7-d15611354747@kernel.org>
Date: Tue, 7 Nov 2023 23:17:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20231107044434.157292-1-ebiggers@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231107044434.157292-1-ebiggers@kernel.org>
X-Headers-End: 1r0Npv-00ATR2-Df
Subject: Re: [f2fs-dev] [PATCH] f2fs: explicitly null-terminate the xattr
 list
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/11/7 12:44, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When setting an xattr, explicitly null-terminate the xattr list.  This
> eliminates the fragile assumption that the unused xattr space is always
> zeroed.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
