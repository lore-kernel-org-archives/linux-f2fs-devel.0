Return-Path: <SRS0=hEcs=VA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C872FC5B57D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jul 2019 02:07:20 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A242063F;
	Wed,  3 Jul 2019 02:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ixjHT4/I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="DHRIw7gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A242063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hiUfu-0004Kr-OJ; Wed, 03 Jul 2019 02:07:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hiUft-0004Kg-H1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jul 2019 02:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3SSiTTdi6bWoEp81VHgLmetHilF4I/sbR7Ysh5i/mGo=; b=ixjHT4/IIGY0ZhSVPrJjPN3jhZ
 rzErJvMwn676NBee8BF8oGWhzxLCJ4/9I+XFAsmZCxvHYmWj6NnRVbDeJgD5HO9gjAKczMdpthAKs
 o88tzwfAJAEf+VlwHrTJbGGvkuh/+baq14eRmhUBKOiLwVULFBwXMAVvfHHWvK8RR/Z4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3SSiTTdi6bWoEp81VHgLmetHilF4I/sbR7Ysh5i/mGo=; b=DHRIw7gsDxCf1QIrVSeA3L17en
 tfSK50gOUnQHYffRXpejzEdcmTHZyTt5XQYhlH5GjEOir43T7JEUeCk9sCJdQ9nXP4D7UK/PBQe8H
 U0C2ECpMgFkebCWURXXOjuXq3SmGrWZLdkVFuvQSvsuP+3QnXOAZlzbWEzKk28BOb5x4=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hiUg1-005jP9-SQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jul 2019 02:07:19 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 457DCBC5A1295040C698;
 Wed,  3 Jul 2019 10:07:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 10:07:03 +0800
To: Ocean Chen <oceanchen@google.com>, <jaegeuk@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20190702080503.175149-1-oceanchen@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
Date: Wed, 3 Jul 2019 10:07:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190702080503.175149-1-oceanchen@google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hiUg1-005jP9-SQ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid out-of-range memory access
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ocean,

If filesystem is corrupted, it should fail mount due to below check in
f2fs_sanity_check_ckpt(), so we are safe in read_compacted_summaries() to access
entries[0,blk_off], right?

	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
			return 1;

Thanks,

On 2019/7/2 16:05, Ocean Chen wrote:
> blk_off might over 512 due to fs corrupt.
> Use ENTRIES_IN_SUM to protect invalid memory access.
> 
> v2:
> - fix typo
> Signed-off-by: Ocean Chen <oceanchen@google.com>
> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8dee063c833f..a5e8af0bd62e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>  
>  		for (j = 0; j < blk_off; j++) {
>  			struct f2fs_summary *s;
> +			if (j >= ENTRIES_IN_SUM)
> +				return -EFAULT;
>  			s = (struct f2fs_summary *)(kaddr + offset);
>  			seg_i->sum_blk->entries[j] = *s;
>  			offset += SUMMARY_SIZE;
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
