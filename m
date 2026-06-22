Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD04CD98F0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UGJkSZroJ4b5mM1C4vp5i3NrctPN/T9XEUjOQ34HFag=; b=eP+BJo+CzziDAUz9HGgipDS/ue
	t0WfyA6DJ0araVLIuWs/xc1i6EA9MLPzI5aMqQGS6kfX+w46ijya/n0eo2E0nhIxGM9oKkC3nCZcV
	jBNzmrMH6NfW0xr59PcgsHmlczhCwKWaUgQVl68EPxZPr5K0ptz9+Xuvo2uP3HapDcKI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbTOH-0007v1-Pg;
	Mon, 22 Jun 2026 01:23:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wbTOF-0007ur-N3
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 01:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PD6FDPyWUVvXtNbAeYAkqONlzLQlXrWeVKkkNyoNXi8=; b=XOTVaUCuogWQ6ej04v1o5sozqA
 THc8iacG/p2ydj9ykX1aQro0QbSEFpjsNCXbEhXW3+2MXl49QKuOx2sFPya5+jOVgehuszX20+6UB
 d90LFfXofmpj8Ptc7dbGcpDRLVNXV4iJ96MjsxHRxWo9Ypj3Gjk5N4WS75kmVtEgyvSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PD6FDPyWUVvXtNbAeYAkqONlzLQlXrWeVKkkNyoNXi8=; b=GMaF5gCqSAWBGehhcALvJUqHT/
 J9artMi/oTQ2SpJOYs91TWCxHzEToF7kl5s97TkW/OfpQsk1oIc8aadusEHgd2rWegW7/hLO9aNbJ
 88a9RG7JE+Xc8QXQZkgdNoV0j4V0AhTLDMrjLWCaAggqenFTgEDGUc1tWH16Id2zFgfQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbTOF-0001wh-FM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 01:23:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A00D60051;
 Mon, 22 Jun 2026 01:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A2C1F000E9;
 Mon, 22 Jun 2026 01:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782091425;
 bh=PD6FDPyWUVvXtNbAeYAkqONlzLQlXrWeVKkkNyoNXi8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bIzh/VTMdXrki3KXykUFpwu4w9ZzJUwepbQHtWYZZ67ZXv4w/VELKtSrBrRQKehaz
 uZyoZed+ee/GadRZWGh8hAhmPI6+juk7MuRmqGu15gODMATPdjVhrjDkpUrfRp6rb9
 GbhSUPl/PodV+sGTeXnP0jh52AU8qggSO9jeoyUPwVZGjVnTDLY9MV9nBMhpuoLh0O
 mErN0FEqa6Y/B+BhlMXgSb+sIfTEDjcSxD6DEZkgCaUv60gG/O35eVEGv6qtOrlB98
 3PrYYCnWajdUqtR9MYUavt6uNGTmTh/VqsfmeUtKtHHRekJ8thDIhxkCgGDXvUFQ+I
 qcx0b96Fchs5w==
Message-ID: <f2827427-4b83-4334-9201-fd8f62246875@kernel.org>
Date: Mon, 22 Jun 2026 09:23:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keshav Verma <iganschel@gmail.com>, jaegeuk@kernel.org
References: <20260618200105.3551-1-iganschel@gmail.com>
Content-Language: en-US
In-Reply-To: <20260618200105.3551-1-iganschel@gmail.com>
X-Headers-End: 1wbTOF-0001wh-FM
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix listxattr handling of corrupted
 xattr entries
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/19/26 04:01, Keshav Verma wrote:
> Validate the xattr entry before reading its fields in f2fs_listxattr().
> Return -EFSCORRUPTED when the entry is outside the valid xattr storage
> area instead of returning a successful partial result.
> 

Fixes line and Cc: stable@kernel.org

> Signed-off-by: Keshav Verma <iganschel@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/xattr.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 610d5810074d..18f495db20d2 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -581,8 +581,6 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>   		size_t prefix_len;
>   		size_t size;
>   
> -		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
> -
>   		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
>   			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
>   			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
> @@ -590,9 +588,12 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>   			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>   			f2fs_handle_error(F2FS_I_SB(inode),
>   						ERROR_CORRUPTED_XATTR);
> -			break;
> +			error = -EFSCORRUPTED;
> +			goto cleanup;
>   		}
>   
> +		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
> +
>   		if (!prefix)
>   			continue;
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
