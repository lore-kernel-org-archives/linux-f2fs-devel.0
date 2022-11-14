Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9D8C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Nov 2022 07:29:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ouTuY-0004Au-Hh;
	Mon, 14 Nov 2022 07:29:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ouTuX-0004Aj-B7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 07:29:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W+Vpb7G0Yzu+LNjMvncjccnXJ4EqC53nXxFUbaN7YNY=; b=GM35qmdYnAHSVGVB57Cm1TCebR
 a1AS4GTkM9SsRQwFNHAvJx75P2DGAp8jsUoZtbJi9PHLISZYKvSRDJJdogWaekFptf/0WgTSAsHLQ
 YCPiI5UU5ucmCfVZqXES/oF/pJ9Ts87e0lOQuUT1lDQ8wlg4yJKPVUT1ozdoa+/MmddU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W+Vpb7G0Yzu+LNjMvncjccnXJ4EqC53nXxFUbaN7YNY=; b=bNzPhj0fkqeblVUNxcX8cEOL4s
 MPOBCaGaupC7TFTX+eydf66r9Ryy5xumbDtam4fNTyshKZcH9BhPCEv2XJgvepmyLQGVFL7+a7r3s
 TE7pQ4XUeW5GtWO0Ss9/GDCUkWLcpys9+dC7j2wW4PaUhl1R5hgtoBGBJMV+ap9b7C3o=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ouTuW-007eTx-Jo for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 07:29:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 515DDB80CBF;
 Mon, 14 Nov 2022 07:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24737C433C1;
 Mon, 14 Nov 2022 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668410973;
 bh=aZwRcXna8lwJ7Qw5CKLwI2wHpbAgMyMwKlqpn6bIzck=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cLMhwMtS6slVE6TkYIprjcvQ++u7NxWTao9vhjAHLfXMuPGtolPaQj+yHdFMaMQzL
 0wdPk1TouBqeleTygPIKRi+rc7kVmBxYonOHwgfM1auWqMccLWbsffkXphj74TWQUL
 2mej5cuZNfYmLAv/ZmxYNP2Jvh2Pw9IDDfUEuTYamIONucu1kZa174968iNHsUBTsQ
 4sLt+0oxIs44jsTLGdfI73Xsf/PeL6E80taDDAvsNygyAj1UBZJUuhu+/VrkHNeXBZ
 mz1kIgRgbgL/WTEiOlFvzlqmxCWhfT3l09nOsNmd0vRSW3Mc8WTA5Xkf7ITBD3/JT0
 U/W6duqD4a0Bg==
Message-ID: <12baae96-c00f-a127-3db5-49160cdc46e3@kernel.org>
Date: Mon, 14 Nov 2022 15:29:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20221110140723.92752-1-shengyong@oppo.com>
 <20221110140723.92752-4-shengyong@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221110140723.92752-4-shengyong@oppo.com>
X-Headers-End: 1ouTuW-007eTx-Jo
Subject: Re: [f2fs-dev] [PATCH 4/4] fsck.f2fs: avoid uncessary recalculation
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/10 22:07, Sheng Yong wrote:
> There is no need to recalculate ADDRS_PER_INODE and ADDRS_PER_BLOCK,
> especially in a for loop.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>   fsck/fsck.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index ebc60ad..ec096f2 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -706,7 +706,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>   	int ofs;
>   	char *en;
>   	u32 namelen;
> -	unsigned int idx = 0;
> +	unsigned int addrs, idx = 0;
>   	unsigned short i_gc_failures;
>   	int need_fix = 0;
>   	int ret;
> @@ -932,17 +932,16 @@ check_next:
>   	}
>   
>   	/* check data blocks in inode */
> +	addrs = ADDRS_PER_INODE(&node_blk->i);
>   	if (cur_qtype != -1) {
> +		unsigned int addrs_per_blk = ADDRS_PER_BLOCK(&node_blk->i);
>   		qf_szchk_type[cur_qtype] = QF_SZCHK_REGFILE;
> -		qf_maxsize[cur_qtype] = (ADDRS_PER_INODE(&node_blk->i) +
> -				2 * ADDRS_PER_BLOCK(&node_blk->i) +
> -				2 * ADDRS_PER_BLOCK(&node_blk->i) *
> -				NIDS_PER_BLOCK +
> -				(u64) ADDRS_PER_BLOCK(&node_blk->i) *
> -				NIDS_PER_BLOCK * NIDS_PER_BLOCK) * F2FS_BLKSIZE;
> -	}
> -	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i);
> -						idx++, child.pgofs++) {
> +		qf_maxsize[cur_qtype] = (addrs + 2 * addrs_per_blk +

u64(addrs + 2 * addrs_per_blk +

Otherwise, the result may overflow...

Thanks,

> +				2 * addrs_per_blk * NIDS_PER_BLOCK +
> +				(u64) addrs_per_blk * NIDS_PER_BLOCK *
> +				NIDS_PER_BLOCK) * F2FS_BLKSIZE;
> +	}
> +	for (idx = 0; idx < addrs; idx++, child.pgofs++) {
>   		block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[ofs + idx]);
>   
>   		/* check extent info */


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
