Return-Path: <SRS0=w2wC=BO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE27C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2020 03:55:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28988206F6;
	Tue,  4 Aug 2020 03:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="g6XVMPA9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BFvthph2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEbXUgW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28988206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k2o2Q-0007Xp-La; Tue, 04 Aug 2020 03:54:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1k2o2P-0007XG-SX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Aug 2020 03:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TpI9IhCEHthKGTZrHCMr/VHf05i3WRZPRjEWFD/sgMs=; b=g6XVMPA9lB4M7K2gMD+uyFTPfu
 Z0reC0v3RLvGDgm4SYU6jDFUZL49x2mG5plaSAx9bXsnyp8Tc6ehexYAbVpJMIeQMZXQS5eArWhVY
 q4sJ25dAsybP4p0Ohqa7ZDnoN44d9lYU3Yiq+0FH8iqJFFpYosB+MjiMzXsrMXLMsfAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TpI9IhCEHthKGTZrHCMr/VHf05i3WRZPRjEWFD/sgMs=; b=BFvthph2UPp8ayu6UQ1TSPh/VE
 U+hG98+U3HmfGP/oA1smJ1AhU+bOljSOK596OYxGjCmMobhgcB51/G4w3xGde/2ltliimE39GZozU
 46gF4pgQncEdV6SXGy6eN+mNx4Iazks2sPnTCRtvUUbk/ZSFz2T2aLbZxdadrrT05uoA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k2o2O-00BK4J-0Z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Aug 2020 03:54:53 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB9DD206F6;
 Tue,  4 Aug 2020 03:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596513280;
 bh=1wIRTKIibHj2cuI0fbbKzQxUIbvtAf6aPbLlnn72kQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qEbXUgW3AcpI2xod1XByY6z3bwg8Y/HzIsjplM1wVG4q6mFuvd1L2OpV6Lnza4GpY
 +1tgSWn0K6UAVPxO0/NMjLZRxD38usgw0MvkfHrpzeDM+qTH/uEchteYXOu4xotkSv
 GuCwsksVXLhfcmLfkXVamKL3a/P4sHSVUaddoUmQ=
Date: Mon, 3 Aug 2020 20:54:39 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200804035439.GA903802@google.com>
References: <20200729070244.584518-1-jaegeuk@kernel.org>
 <670f35e1-872b-6602-320c-dd73bcb62510@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <670f35e1-872b-6602-320c-dd73bcb62510@huawei.com>
X-Headers-End: 1k2o2O-00BK4J-0Z
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock between quota writes and
 checkpoint
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/04, Chao Yu wrote:
> On 2020/7/29 15:02, Jaegeuk Kim wrote:
> > f2fs_write_data_pages(quota_mapping)
> >   __f2fs_write_data_pages             f2fs_write_checkpoint
> >    * blk_start_plug(&plug);
> >    * add bio in write_io[DATA]
> >                                        - block_operations
> >                                        - skip syncing quota by
> >                                                  >DEFAULT_RETRY_QUOTA_FLUSH_COUNT
> >                                        - down_write(&sbi->node_write);
> 
> f2fs_flush_merged_writes() will be called after block_operations(), why this doesn't
> help?

Well, I think bio can be added after f2fs_flush_merged_writes() as well.

> 
> >    - f2fs_write_single_data_page
> >      - f2fs_do_write_data_page
> >        - f2fs_outplace_write_data
> >          - do_write_page
> >             - f2fs_allocate_data_block
> >              - down_write(node_write)
> >                                        - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA);
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/checkpoint.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 8c782d3f324f0..99c8061da55b9 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1269,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
> >   		if (type == F2FS_DIRTY_META)
> >   			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
> >   							FS_CP_META_IO);
> > +		else if (type == F2FS_WB_CP_DATA)
> > +			f2fs_submit_merged_write(sbi, DATA);
> >   		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
> >   	}
> >   	finish_wait(&sbi->cp_wait, &wait);
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
