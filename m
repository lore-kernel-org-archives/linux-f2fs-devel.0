Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBA9C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Nov 2022 15:32:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oxrjq-0004r8-9q;
	Wed, 23 Nov 2022 15:32:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oxrjp-0004qy-0T
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Nov 2022 15:32:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vTXk7yds5YMDP1kgbHNt68VDKzyZlhhS4gASNL4p8/M=; b=C93uNDyHfQvGiDxWubX/OMNcrD
 gBqZ+67Iewucrk9mccpZBXkL68PYqStOayEdeVu2mD91OHqZEzoX7MIAEnyZrHQi0cyB5gsFtKaCa
 Dkc2EzDbIix34nYR60H9OC3Fd7Xkj/GX/Juj/2E2cvMmgvKkRpbFy2kJH8ljTOnZtZT0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vTXk7yds5YMDP1kgbHNt68VDKzyZlhhS4gASNL4p8/M=; b=HUinJR8pRp+01UpMvslcNkGuSS
 dB4qyRsqnP6zLU+1cChMlhlx0wwikMVXa2OljIQJ+4y+wP5BfMZCP0jYE0z4I4fqD8Mz5tHTuClaI
 5V1E4L4D3YxHNgGOm005HJsTKVJ7dcIASmXUi732dh5ypEKm8uovQrEwuejhFNsSQwjs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oxrjo-0005aF-9N for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Nov 2022 15:32:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED1861D9C;
 Wed, 23 Nov 2022 15:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D9EC433C1;
 Wed, 23 Nov 2022 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669217547;
 bh=EQbFmhmMMXuH6+6uZrIYcXutlZ6F7K3p17xIjSCufVM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q8bl9v2SWSU5sMUrkleHxm6qMCL+U3sGzp3Lq+Y40c4jGsE5ELYfaQg1RpRmCcnEp
 AqnZsjW8Y4dkO58IKb1kAUmA1GRgMasBKrJhFeBqHOWDcAutLSg7sXTbjFji24BzzB
 La9z+xkr/2vzptMQnZci/CzqjqkA4bjmMjUD8ZLLrl0KV47BAzmcexPsjy5YKLio2p
 vACG6Wmob8kdI+wUYU9fyfKxXlqU1Rr63sjZGt3I2T5LXEzNMNCEbWDND2xC6f0To8
 kWx2SiOhMQmZqaoWeLrOPGh5dp6ER1iQy39Bul1eUq2urmdosgCyVSUSblQo0Qn5sR
 4wPbWkWZHDYmA==
Message-ID: <3cc667aa-cff0-f2c8-84d0-995871f31d7d@kernel.org>
Date: Wed, 23 Nov 2022 23:32:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221117143509.58913-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221117143509.58913-1-frank.li@vivo.com>
X-Headers-End: 1oxrjo-0005aF-9N
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce discard_urgent_util sysfs
 node
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/17 22:35, Yangtao Li wrote:
> Through this node, you can control the background discard
> to run more aggressively when reach the utilization rate of
> the space.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
>   fs/f2fs/f2fs.h                          | 1 +
>   fs/f2fs/segment.c                       | 3 ++-
>   fs/f2fs/sysfs.c                         | 9 +++++++++
>   4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 24e7cb77f265..202ac1bfc6f2 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -646,3 +646,11 @@ Date:		October 2022
>   Contact:	"Yangtao Li" <frank.li@vivo.com>
>   Description:	Show the current gc_mode as a string.
>   		This is a read-only entry.
> +
> +What:		/sys/fs/f2fs/<disk>/discard_urgent_util
> +Date:		November 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	When space utilization exceeds this, do background DISCARD aggressively.
> +		Does DISCARD forcibly in a period of given min_discard_issue_time when the number
> +		of discards is not 0 and set discard granularity to 1.
> +	    Default: 80
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dedac413bf64..fe42ac74491d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -411,6 +411,7 @@ struct discard_cmd_control {
>   	unsigned int min_discard_issue_time;	/* min. interval between discard issue */
>   	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
>   	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
> +	unsigned int discard_urgent_util;	/* utilization which issue discard proactively */
>   	unsigned int discard_granularity;	/* discard granularity */
>   	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
>   	unsigned int undiscard_blks;		/* # of undiscard blocks */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8b0b76550578..575c24b42df9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1069,7 +1069,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>   		dpolicy->io_aware = true;
>   		dpolicy->sync = false;
>   		dpolicy->ordered = true;
> -		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
> +		if (utilization(sbi) > dcc->discard_urgent_util) {
>   			dpolicy->granularity = 1;
>   			if (atomic_read(&dcc->discard_cmd_cnt))
>   				dpolicy->max_interval =
> @@ -2085,6 +2085,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
>   	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
>   	dcc->max_discard_issue_time = DEF_MAX_DISCARD_ISSUE_TIME;
> +	dcc->discard_urgent_util = DEF_DISCARD_URGENT_UTIL;
>   	dcc->undiscard_blks = 0;
>   	dcc->next_pos = 0;
>   	dcc->root = RB_ROOT_CACHED;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 97bf0dbb0974..a7dc726054b9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -493,6 +493,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "discard_urgent_util")) {
> +		if (t == 0 || t > 100)

0 is allowed?

Thanks,

> +			return -EINVAL;
> +		*ui = t;
> +		return count;
> +	}
> +
>   	if (!strcmp(a->attr.name, "migration_granularity")) {
>   		if (t == 0 || t > sbi->segs_per_sec)
>   			return -EINVAL;
> @@ -795,6 +802,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_request, max_discard_req
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
> +F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_urgent_util, discard_urgent_util);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_ordered_discard, max_ordered_discard);
>   F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
> @@ -925,6 +933,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(min_discard_issue_time),
>   	ATTR_LIST(mid_discard_issue_time),
>   	ATTR_LIST(max_discard_issue_time),
> +	ATTR_LIST(discard_urgent_util),
>   	ATTR_LIST(discard_granularity),
>   	ATTR_LIST(max_ordered_discard),
>   	ATTR_LIST(pending_discard),


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
