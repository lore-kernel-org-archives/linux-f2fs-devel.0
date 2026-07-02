Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B79C43327
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0THU1WTYCfS99XBvjDgSX8GNFABLTWxRn+cU4EhP7x4=; b=Kk/uVpoyFOs6UCSlEYGIgLVhcx
	N5NgUHNVeY+cTcyKq62W3Jkz26QwXwsCLH7UHq1Fk9m5PjcakjhKzBSCiq/lixWbjGB+r8GJdxe2J
	ZwIa0z+DVp7XdxJSPcF6kDQWb/xj3aDNc84CpZjnzQNUxp2AV7joatJgeInZYFvmLnn0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfKdQ-0002mZ-Nh;
	Thu, 02 Jul 2026 16:51:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wfKdP-0002m6-Ap
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 16:51:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ydgqm4JLD9wHorHnF+2XAPjVnBLFS4UbABn2TMKW9lg=; b=nH83UhJF4t+PoxInL91hAtK7X+
 rFoAkm69idubJUsQ8M8A3d+mUAnKdjtOILi+sHh1Qvfd8wXh1TkYSPs9pR7hX2Wcf6FP1G+iYLaqn
 S8Y6d4XoZ3xDq4xIQWI2jaJm3jxKNxvVF3V+YWitJZ93/sf58Tk2skSe+6eiD9QQ4tC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ydgqm4JLD9wHorHnF+2XAPjVnBLFS4UbABn2TMKW9lg=; b=LyHx16wlZvYfOeQGtkzX9YNzgf
 pvQeQNHjwJfqL8B0VBhMTlsMWrOnz97m3o1Rzke/x51VTeXiDlvwihCuBMFjuCOXPCflvRYsohhA6
 Tuw8JNdRQwHyvCudp7vCSHxROsvWPtMQU8sDrOqvLi+ibpuRhWiE47i4/6QOcf+PiWbc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfKdL-0005XL-Uv for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 16:51:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 1383940C06;
 Thu,  2 Jul 2026 16:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D15C81F000E9;
 Thu,  2 Jul 2026 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783011078;
 bh=ydgqm4JLD9wHorHnF+2XAPjVnBLFS4UbABn2TMKW9lg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ymepa36TovSJKNYZV3u+xpDtmvDD0jgD8tu6oITOhStEqSB4dFm2GSNjYvX6a/XhD
 idd1sj/Z9E/KlApdD9cMjRLqTlqdgS1ZGfahdEB1adsC1jHUM18Idy2FDJdP+91o7q
 QlYswMBkWSAqfhgV/t0BjA2QDKkEneDGjH+Gl5qKC5w3Z9fiVXFpsrFrRHn8BhtWaG
 lcACOAbDkojouQsXQtSoi47LOb5OGkLJW+AXDJEZT+ElhlEosUQhZ2/nNXhEJR9+aI
 PyMC3eJrsnz1BJ5WVFaLKabv6f9zwLwtBLpgZ7fU4xVDkd9t8o3JJ3wtYAC95RX0Zj
 PrPeMRFBP/AuA==
Date: Thu, 2 Jul 2026 09:51:17 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260702165117.GK9392@frogsfrogsfrogs>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com>
 <20260702140705.GE21339@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260702140705.GE21339@lst.de>
X-Headers-End: 1wfKdL-0005XL-Uv
Subject: Re: [f2fs-dev] [PATCH v2 17/18] iomap: pass iomap_next_fn directly
 instead of struct iomap_ops
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Ritesh Harjani \(IBM\)" <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Chunhai Guo <guochunhai@vivo.com>, Dan Williams <djbw@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 Yue Hu <zbestahu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Zhang Yi <yi.zhang@huawei.com>, willy@infradead.org,
 hsiangkao@linux.alibaba.com, Gao Xiang <xiang@kernel.org>,
 "open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:FUSE FILESYSTEM \[CORE\]" <fuse-devel@lists.linux.dev>,
 brauner@kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, "open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>,
 "open list:FILESYSTEM DIRECT ACCESS \(DAX\)" <nvdimm@lists.linux.dev>,
 Hongbo Li <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>,
 "open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jul 02, 2026 at 04:07:05PM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> In terms of merge logistics, I wonder if we should delay this and
> the previous patch to the next merge window so that we can minimize the
> cross-subsystem merge pain with more file system iomap conversion.
> If none of them actually happen until rc6 or so, orif  the merges aren't
> painful we could still pick them up late in the merge window.

I'd say everything but this patch should go in during the merge window
for 7.3, along with clear instructions to brauner/torvalds to expect
this patch to appear right before 7.3-rc1 gets tagged, to clean up all
the other changes that come in.

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
