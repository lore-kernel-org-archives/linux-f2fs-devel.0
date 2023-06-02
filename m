Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD6BC7EE24
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Jun 2023 09:39:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q51FX-0004Kx-Ku;
	Fri, 02 Jun 2023 09:39:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q51FV-0004Kq-VA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 09:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mEBm3lolxYmN9Eg6exfRQzT3c3BzQBNJFhm4eSX4/MY=; b=Z2Sjjtlb/bPkfFr9OSwRtYEv1r
 UbH6WnR3vZYxLvxxCthdF27HyHwL0Ho10JNUN22KnZ6/rAQcl+2EHwc2KrdsU/eCssSZ4oS1CMhkU
 H8YtgA/u4WsT6cgrjsxK/ucjVnjVwkEImFfkSsGjk1svmnqFS5T9y33CiLwyQBND4Heg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mEBm3lolxYmN9Eg6exfRQzT3c3BzQBNJFhm4eSX4/MY=; b=cYB5uG6BGccX41qfEPMlNoTMd8
 V+P7Wqz9UwWPZwyaP57qC4HFU1g/5Gj7KCRfK9as//ilH18vSO0lpPB4kmp32F1xseEBDMnC6hfsK
 YDa3a1GSlPohChC2syzt1CN1+YkzEwPPk0fiMDr56SG63u1YMSuxVdxde8xrRD4jKdy8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q51FS-0007u7-0W for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 09:39:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3739360AFA;
 Fri,  2 Jun 2023 09:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976E9C433EF;
 Fri,  2 Jun 2023 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685698733;
 bh=eTGJKsIm6xfh2a0IRVtfmLa6Wy7RqLcvF2owGLAjSOQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aXwv4zhDxzodEzB/9JyT2q8fuIiooObup9YrYYRbQGlOKRaAG43EdrIqzS6wYyWT0
 yOprjcUaTwLfpjgKLKHFS14BlIeXGufqauHKZqBhQMgbAuW6g/r1r+e0gMa4HaKGNw
 ZgL9/+4BfPLTpzyenVjuvxV6UBq/3AMlfsmNJKFoLKMMotzWMbx2YXlpBfN/htKOJd
 xdRlaK09TMQQgkyv3/Z56teB9ymy9BO60TW/iJCgVuTvMjn+FKNLwRwL8nUXc22p92
 zc1gQBpDTB88fx+ApQcnmOLLn95EtzLywOAr7qK36a5qPHd9bKEPX8yxcUKyroR9To
 QZwjKsg73hZpQ==
Message-ID: <faae35b2-db70-23ef-3469-7fe31d24618d@kernel.org>
Date: Fri, 2 Jun 2023 17:38:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230531065142.365199-1-korotkov.maxim.s@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230531065142.365199-1-korotkov.maxim.s@gmail.com>
X-Headers-End: 1q51FS-0007u7-0W
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: fix potential NULL dereference
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
Cc: Maxim Korotkov <maskorotkov@rasu.ru>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/31 14:51, Maxim Korotkov wrote:
> The input pointer "parent" was used unsafely
> before checking against NULL
> 
> Found by RASU JSC with Svace static analyzer
> Fixes: 603f8f9d3(sload.f2fs: support loading files into partition directly)
> Signed-off-by: Maxim Korotkov <maskorotkov@rasu.ru>
> ---
>   fsck/dir.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fsck/dir.c b/fsck/dir.c
> index 4a3eb6e..925fe14 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -225,19 +225,23 @@ int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
>   	int level = 0, current_depth, bit_pos;
>   	int nbucket, nblock, bidx, block;
>   	int slots = GET_DENTRY_SLOTS(name_len);
> -	f2fs_hash_t dentry_hash = f2fs_dentry_hash(get_encoding(sbi),
> -						IS_CASEFOLDED(&parent->i),
> -						name, name_len);
> +	f2fs_hash_t dentry_hash;
>   	struct f2fs_dentry_block *dentry_blk;
>   	struct f2fs_dentry_ptr d;
>   	struct dnode_of_data dn;
> -	nid_t pino = le32_to_cpu(parent->footer.ino);
> -	unsigned int dir_level = parent->i.i_dir_level;
> +	nid_t pino;
> +	unsigned int dir_level;
>   	int ret;
>   
>   	if (parent == NULL)
>   		return -EINVAL;
>   
> +	dentry_hash = f2fs_dentry_hash(get_encoding(sbi),
> +						IS_CASEFOLDED(&parent->i),
> +						name, name_len);	

Unneeded indent after ';', otherwise it looks good to me.

Thanks,

> +	pino = le32_to_cpu(parent->footer.ino);
> +	dir_level = parent->i.i_dir_level;
> +
>   	if (!pino) {
>   		ERR_MSG("Wrong parent ino:%d \n", pino);
>   		return -EINVAL;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
