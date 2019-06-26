Return-Path: <SRS0=M3qu=UZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B393C4646B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jun 2019 04:12:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE67F20645;
	Wed, 26 Jun 2019 04:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ak2tnFKQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ATLP4+Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE67F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfzI3-0006di-Py; Wed, 26 Jun 2019 04:12:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <viro@ftp.linux.org.uk>)
 id 1hfzI2-0006dK-JU; Wed, 26 Jun 2019 04:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rH4OF0GHPClOZ4K9k6rCWew4+MWIr6v83apdz0y+Mu4=; b=Ak2tnFKQVG4SP3Qp/bHhalEFc
 059qSb2TZBycHGyWpbPPR+uvra8QGSwsHLQSnAOHGK5QTTeF3B7za34nIMuaPnp6YyIWuSDZ5g/eG
 18xBDkDC96PN6Hnuy0Pu0+buTH1L1Ha9HZoL+3VaQuSi+cQS+Ytwd2cD6DiIC7egh2xVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rH4OF0GHPClOZ4K9k6rCWew4+MWIr6v83apdz0y+Mu4=; b=ATLP4+HuRwmNLtUvFNJRV+wdHP
 N8J71OgmsL4aaFnsk71skhCpxCABLHydFuFEdw2c420H/JZqJt6ekwsd9qy4+gteoTthda47RXLlN
 zK59WQoNq+fLuyWCZS8RmBbDdK4ChAxq7UjMvZYRHskOfRcUgHC020YY+tjdW+oWCEms=;
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfzI9-00AMpy-6y; Wed, 26 Jun 2019 04:12:21 +0000
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hfzHR-0000Pn-Ag; Wed, 26 Jun 2019 04:11:33 +0000
Date: Wed, 26 Jun 2019 05:11:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID: <20190626041133.GB32272@ZenIV.linux.org.uk>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
 <156151633829.2283456.834142172527987802.stgit@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156151633829.2283456.834142172527987802.stgit@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Headers-End: 1hfzI9-00AMpy-6y
Subject: Re: [f2fs-dev] [PATCH 2/5] vfs: create a generic checking function
 for FS_IOC_FSSETXATTR
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
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>, hch@infradead.org,
 linux-btrfs@vger.kernel.org, clm@fb.com, adilger.kernel@dilger.ca,
 matthew.garrett@nebula.com, linux-nilfs@vger.kernel.org,
 cluster-devel@redhat.com, linux-ext4@vger.kernel.org, josef@toxicpanda.com,
 reiserfs-devel@vger.kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
 tytso@mit.edu, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 jk@ozlabs.org, jack@suse.com, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 25, 2019 at 07:32:18PM -0700, Darrick J. Wong wrote:
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -373,10 +373,9 @@ static int check_xflags(unsigned int flags)
>  static int btrfs_ioctl_fsgetxattr(struct file *file, void __user *arg)
>  {
>  	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
> -	struct fsxattr fa;
> -
> -	memset(&fa, 0, sizeof(fa));
> -	fa.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);
> +	struct fsxattr fa = {
> +		.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags),
> +	};

Umm...  Sure, there's no padding, but still - you are going to copy that thing
to userland...  How about

static inline void simple_fill_fsxattr(struct fsxattr *fa, unsigned xflags)
{
	memset(fa, 0, sizeof(*fa));
	fa->fsx_xflags = xflags;
}

and let the compiler optimize the crap out?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
