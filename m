Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0275BEB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jun 2023 18:50:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qClrV-0001DJ-3v;
	Fri, 23 Jun 2023 18:50:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qClrS-0001D7-3B
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jun 2023 18:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h1dj5bFlPohl7wgGOgqGB5+Ux4XZkmQ/XSwShDtU3Vw=; b=UnkizA0ESXOgh+wCwIWIjJcxeB
 KgYPC39TbsfO0bQx2uioIvJm7zygh8WSXhpiC4fVdDCq/FfdwNEfLfDqUyBRiOZPvdVvvlGCA0O5E
 2yXaCHqlvgGQd2y1NPrDMtqTtEKw9eup6AhmzRJsAHYe6mL3kZUmv2V/IGPIwOs6pm5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h1dj5bFlPohl7wgGOgqGB5+Ux4XZkmQ/XSwShDtU3Vw=; b=FZSa1l91yXVeuqa7TB/kFXDeAb
 tuXlxOGOYPt3qMrm/Q6LtkM9ZNqTZGkDBOBpGIdluQ7JuuCq+S8SFgH2TA4+UyR704VEBb0vWWf6t
 rTveG6lbQyFWwbek0AnOTGZSPGkr38/lp7T8yOkyWYhWdKONx5/OwWqaLzelBsOBRcNM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qClrN-00CcZ1-3O for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jun 2023 18:50:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A2FD661AC1;
 Fri, 23 Jun 2023 18:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F65C433C0;
 Fri, 23 Jun 2023 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687546211;
 bh=g4YGxnWTSycoQVRfxqHx9G+BUtcP9EfCAE/9h3HVpYk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XD+clXTp7RDtdF/h7UCeN7Z44LUmq33bpKyxV1Hf8lsdjE8cBM7Mu0izY+7bp8FLh
 xKmBPQCapbLnlD/4u082SghJQfvzYGqViHnb1aESunWoiXZkIW+Uo+HgQBjn/UoROS
 hjkPi+3H4xDC0F2zEq40SMY1q/BCQMPMS5dqoXCMi6cHijBLZ0Xe7G/KTnHbWs7y6F
 62V3NexXnh7FTiTr6JxPR+DVuJLft4yMBbmkzcKwNJoVlZqoRHxfWRdnmFOP7aL4Wr
 6F+VVXe3DO7dDUU9qGgboyqi2ktBwe+2jECbhE1corilISWMB4HBBFD02FUX4l5QwS
 o6CZYKCzM2KmA==
Date: Fri, 23 Jun 2023 11:50:09 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZJXpYR7eRVf+Gfj/@google.com>
References: <20230524024204.13694-1-guochunhai@vivo.com>
 <5dade26f-9c0c-8022-ffdc-ec844ce87f32@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5dade26f-9c0c-8022-ffdc-ec844ce87f32@kernel.org>
X-Headers-End: 1qClrN-00CcZ1-3O
Subject: Re: [f2fs-dev] [PATCH v8] fsck.f2fs: Detect and fix looped node
 chain efficiently
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
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
 frank.li@vivo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/23, Chao Yu wrote:
> On 2023/5/24 10:42, Chunhai Guo wrote:
> > +		if (!c.fix_on) {
> >   			err = -1;
> >   			break;
> >   		}
> 
> One more comment.
> 
> I guess we'd better skip find_fsync_inode() and continue fsck rather
> than exiting directly if c.fix_on is not set, thoughts?

Chunhai, could you please post a final version of this patch?

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
