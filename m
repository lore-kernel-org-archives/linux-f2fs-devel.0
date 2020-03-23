Return-Path: <SRS0=IH0A=5I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F1C3F2CD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:59:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E9920714;
	Mon, 23 Mar 2020 17:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CVuFedMK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fEQAcTUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E9920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGRLp-0008Dh-Km; Mon, 23 Mar 2020 17:59:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1jGRLo-0008DU-5k
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 17:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j6uS0+sM5IVACwdoEpUjiLA6SHSzzBM2i3lfqwxKfH0=; b=CVuFedMK7YhbMYWqo5qAPAVDID
 qS1Zdj9hjHgIPGs376jyw8F3tj2lGsIHPXbdIgxueBy20B0mcsQV9RXDYF0OeIAEIyA2pVQi7lpJV
 k9x6UlZ0KyDqS6y4fwJRpFLdq1sBUcBS5OGuhN5zNk2uvIDxQf0HA6cOARrHUxeeToV0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j6uS0+sM5IVACwdoEpUjiLA6SHSzzBM2i3lfqwxKfH0=; b=fEQAcTUZZtZ/WfXeiUcnMSv1E5
 P1RP6bUMu1iG3URJ02qvkDlqz8W/o355xghVT+sElpKvrbA3SQfXRp1J2ii2X8nRSJVhaiP3J9JEa
 5QtQHQBQJll9M02TpN38iyCwPG6nY08ScFnp81Xywpnt8rYNKNcHHr3TwKK+qXcsf+RY=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGRLk-001AT6-JZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 17:59:00 +0000
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net
 [72.93.95.157]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02NHwcMK029627
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 13:58:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id BDFC6420EBA; Mon, 23 Mar 2020 13:58:38 -0400 (EDT)
Date: Mon, 23 Mar 2020 13:58:38 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Message-ID: <20200323175838.GA7133@mit.edu>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
 <20200320025255.1705972-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200320025255.1705972-2-tytso@mit.edu>
X-Headers-End: 1jGRLk-001AT6-JZ
Subject: Re: [f2fs-dev] [PATCH 2/2] writeback,
 xfs: call dirty_inode() with I_DIRTY_TIME_EXPIRED when appropriate
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

Christoph, Dave --- does this give you the notification that you were
looking such that XFS could get the notification desired that it was
the timestamps need to be written back?

    	       	       	  	  - Ted

On Thu, Mar 19, 2020 at 10:52:55PM -0400, Theodore Ts'o wrote:
> Use the flag I_DIRTY_TIME_EXPIRED passed to dirty_inode() to signal to
> the file system that it is time to flush the inode's timestamps to
> stable storage.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/fs-writeback.c  | 2 +-
>  fs/xfs/xfs_super.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 867454997c9d..32101349ba97 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1506,7 +1506,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  
>  	/* This was a lazytime expiration; we need to tell the file system */
>  	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
> -		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);
> +		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_TIME_EXPIRED);
>  	/* Don't write the inode if only I_DIRTY_PAGES was set */
>  	if (dirty & ~I_DIRTY_PAGES) {
>  		int err = write_inode(inode, wbc);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 2094386af8ac..f27b9b205f81 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -622,7 +622,8 @@ xfs_fs_dirty_inode(
>  
>  	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
>  		return;
> -	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
> +	if ((flag != I_DIRTY_SYNC && flag != I_DIRTY_TIME_EXPIRED) ||
> +	    !(inode->i_state & I_DIRTY_TIME))
>  		return;
>  
>  	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
> -- 
> 2.24.1
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
