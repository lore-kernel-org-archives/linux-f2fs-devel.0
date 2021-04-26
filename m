Return-Path: <SRS0=Zvp+=JX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A02C433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Apr 2021 03:19:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7CA611ED
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Apr 2021 03:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7CA611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1larmh-0000H5-1h; Mon, 26 Apr 2021 03:19:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <hsiangkao@redhat.com>) id 1larmg-0000Gy-1m
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Apr 2021 03:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JkZ1WTY1MMQIKkaGq1w156aYpY5MzfanuNLiTs95e3k=; b=Yfmvne6GVT4B4Sd3YcwYJqhd3O
 9HHNCywLDWX1XSPwhaGzwAnp0DOdFkfyniAgcg4WYz7MaBrRpO0Q4NoF66Wv3Fi4++zxVYAdRn5Aj
 AA1NNb6/ovIVhZct2zU3PsK78GHaKj0PyS1cO9zJ88bmkuwCzZ7hQt72WnTXXDuClmxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JkZ1WTY1MMQIKkaGq1w156aYpY5MzfanuNLiTs95e3k=; b=POWIxYJOFNSyGCQIu7V0RTO8SC
 WQpYlkByAOxCz0xOnX0ydssrjEXBToYOWzVYjZAGNQ07rkRREyx9NTL3GwlvnhUiEPQK38QPMs4pB
 ZpEE03Ks3eJrBqUZgq2/x1Wyht82d89M9KBaa1TY+OqD8hfF+3iauSZWDPMZ0in+kJXI=;
Received: from [170.10.133.124] (helo=us-smtp-delivery-124.mimecast.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1larmV-009pCA-G9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Apr 2021 03:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619407155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JkZ1WTY1MMQIKkaGq1w156aYpY5MzfanuNLiTs95e3k=;
 b=dhUblZTNdBdYtd8lXQuI9GN6ulrjb17L/IFlyuErLPQ0oV2i5rrS5tomdfIkEneItkBYH9
 LKNKJGG7bQ0OFDLqAV/xWWzmy8HNx9vVd9ed7WQJTx9jHBGgUlfW7grkN3rOtbGjhGH17p
 fBpgsvIsiyMgFkLYPwDA6r4zbFrZJdI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ylvAgxykM0Kpe0mkL6zkoQ-1; Sun, 25 Apr 2021 23:19:14 -0400
X-MC-Unique: ylvAgxykM0Kpe0mkL6zkoQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 f2-20020a17090a9b02b0290150d07a9b81so6424372pjp.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Apr 2021 20:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JkZ1WTY1MMQIKkaGq1w156aYpY5MzfanuNLiTs95e3k=;
 b=toxk+heJT6wZkVrKc86UI5JKVlDi5zOk54HRvXkQ69OwT700alQt2wMw+wxeVLcvK+
 2mIkwonj1BnuEU7qeJHph4L4/si3jT7ZVjAi0EqrhQorP/TjuCOcHSD69zySi3+teOwn
 l5NXvYCRwgx78lPM6XWsWZ4PLD4J0ibs5ANV/EPz9X2bigVX1OxsqL3VyldRtBGyHvz0
 FQMJA6OKQUSQBLoky35biw2b0DwEv6PEpfHMpIStpLmdg60m6Sho0kQ3NH6lBg4mUQlV
 N9J04RB3hM48oHNAsM0KSLi3MVPq2XbKq+M3OGnpqpK1dfMK0Hw8MUk2iBpbZVfgN0xk
 A7qw==
X-Gm-Message-State: AOAM530PaS+XhcL6Xqn+xXWhBGDYs6sJllWHW7nXVtJbbKOHl+iOnnm+
 3eztV4GCxDY/i+wRdd/XUQKuoF6rIPlErNDYIG2PwtrqDsbLiKeXHETxjMK+/LXavW/PmKnnUsm
 NL1tMo75jHLxlCa1GcWZh9jPmIiywSRfuDHbnXg==
X-Received: by 2002:a62:5bc1:0:b029:20d:69a5:189 with SMTP id
 p184-20020a625bc10000b029020d69a50189mr15558363pfb.57.1619407152964; 
 Sun, 25 Apr 2021 20:19:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6K08DPGKtzJH3qvDMgct5RWOP7UGYgYhP43E5u7GJCc6rScDVFbuBzv3xqZvBQcj3TH0H/w==
X-Received: by 2002:a62:5bc1:0:b029:20d:69a5:189 with SMTP id
 p184-20020a625bc10000b029020d69a50189mr15558346pfb.57.1619407152686; 
 Sun, 25 Apr 2021 20:19:12 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u1sm9633128pgg.11.2021.04.25.20.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Apr 2021 20:19:12 -0700 (PDT)
Date: Mon, 26 Apr 2021 11:19:02 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Fengnan Chang <changfengnan@vivo.com>
Message-ID: <20210426031902.GA3934275@xiangao.remote.csb>
References: <20210426021153.646-1-changfengnan@vivo.com>
MIME-Version: 1.0
In-Reply-To: <20210426021153.646-1-changfengnan@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1larmV-009pCA-G9
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: avoid unnecessary check in
 f2fs_prepare_compress_overwrite
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Apr 26, 2021 at 10:11:53AM +0800, Fengnan Chang wrote:
> when write compressed file with O_TRUNC, there will be a lot of
> unnecessary check valid blocks in f2fs_prepare_compress_overwrite,
> especially when written in page size, remove it.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Even though I didn't look into the whole thing,
my reaction here is roughly how to handle fallocate with
keep size? Does it work as expected?

> ---
>  fs/f2fs/data.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cf935474ffba..9c3b0849f35e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3270,6 +3270,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct page *page = NULL;
>  	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
> +	pgoff_t end = (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	bool need_balance = false, drop_atomic = false;
>  	block_t blkaddr = NULL_ADDR;
>  	int err = 0;
> @@ -3306,6 +3307,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
> 
>  		*fsdata = NULL;
> 
> +		if (index >= end)
> +			goto repeat;
> +
>  		ret = f2fs_prepare_compress_overwrite(inode, pagep,
>  							index, fsdata);
>  		if (ret < 0) {
> --
> 2.29.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
