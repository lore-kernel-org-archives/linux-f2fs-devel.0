Return-Path: <SRS0=v3Bs=UY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CBAC48BD5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:37:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE1820663;
	Tue, 25 Jun 2019 10:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="EtmgylMp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EzQ0DbMs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpriNPni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE1820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfipb-00050y-JD; Tue, 25 Jun 2019 10:37:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+c5155a46dc30cc8634d8+5784+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1hfipZ-00050p-DC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Jun 2019 10:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1VNqATdiMZjRjBl/SX9aDfK/cY5ROrczskzh7bEhyqQ=; b=EtmgylMpgkRloittS2tBhz45yl
 kCpQxz4/MKGXzSL5NxgVXR+ufF2+t/uwqbLEujAaNPdS3KaiyglVXc2TC0efbiM6Kk7x/NTLJpluL
 Zko2Q0qF2ooV1vxWXgVEhwyEBwKxBL5f3gvaIFVm2aF6l+3kHLP03Ii/4EGUHZ/Rbiig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1VNqATdiMZjRjBl/SX9aDfK/cY5ROrczskzh7bEhyqQ=; b=EzQ0DbMsYAUYaHpzIuStEs0iyt
 ajmPxdxe2DBlOpP0lcgxEmdiUuIcO5QDQgOGL60555EVup3eRgZ6FODHW7g1xV3nMMnSLH6eEDH0i
 mQv2M6ofiIfUeHrzchWuwFwlF7UqREHXYU9mIrF+RdAoLiCxFPcGhvTqxdhgWUqmus80=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfipb-009Ib3-U7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Jun 2019 10:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1VNqATdiMZjRjBl/SX9aDfK/cY5ROrczskzh7bEhyqQ=; b=ZpriNPniMtQfF3PzrXrZFLu9+
 swp27pwzGA3dKtOql8ByZMlmC5XAUIK6Dd+GMHjf0qKANtiVkMY+kP24emwMCRR8Bd7PMgTyLe9QA
 5OqMw/nvM9U3sRjirT+3roDKm/2t058rf3DiyN7fkLSlwMZ0SYle68bvh+fdV+mCDEdE0F8PxUYpO
 6uADPC1wdetL3m6crno/ECGMbIBw4GF5RRX2ugGr6ltI3bjWVADicfMYipFtp/ocudq1CWBwDRZB8
 y8f1S9n0qHQVZzv6yurSepPmJiIiCIwpzAKGBbc00350emRHfZhiQtGnClIv9oYZsJs4CbEdnWkcx
 MCg3FRwHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hfioR-0001Ln-BN; Tue, 25 Jun 2019 10:36:31 +0000
Date: Tue, 25 Jun 2019 03:36:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID: <20190625103631.GB30156@infradead.org>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156116141046.1664939.11424021489724835645.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1hfipb-009Ib3-U7
Subject: Re: [f2fs-dev] [PATCH v4 0/7] vfs: make immutable files actually
 immutable
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
Cc: linux-efi@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 clm@fb.com, adilger.kernel@dilger.ca, matthew.garrett@nebula.com,
 linux-nilfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 devel@lists.orangefs.org, josef@toxicpanda.com, reiserfs-devel@vger.kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, jaegeuk@kernel.org, tytso@mit.edu,
 ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 jk@ozlabs.org, jack@suse.com, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 21, 2019 at 04:56:50PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> The chattr(1) manpage has this to say about the immutable bit that
> system administrators can set on files:
> 
> "A file with the 'i' attribute cannot be modified: it cannot be deleted
> or renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write
> mode."
> 
> Given the clause about how the file 'cannot be modified', it is
> surprising that programs holding writable file descriptors can continue
> to write to and truncate files after the immutable flag has been set,
> but they cannot call other things such as utimes, fallocate, unlink,
> link, setxattr, or reflink.

I still think living code beats documentation.  And as far as I can
tell the immutable bit never behaved as documented or implemented
in this series on Linux, and it originated on Linux.

If you want  hard cut off style immutable flag it should really be a
new API, but I don't really see the point.  It isn't like the usual
workload is to set the flag on a file actively in use.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
