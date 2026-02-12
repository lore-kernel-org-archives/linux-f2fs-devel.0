Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD7FEB48F4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Feb 2026 10:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CNvTlI1cUPBHZH45GdH48ysKyYc1uyHX6rD/nyUmExY=; b=KEZLZcs8l6VsLCFcJGwnLipxZo
	9bOOFJwQf4f6w8hAhGklnMJh6HPC2T9ZtCKvB5DC3bHo8PVW6KWlFcJVkvLlBQGlNK+N69KzBFvA6
	GS/LXCldRUi1gGqC/LEPfdOj2cEZ527oo7sH/oVWmWisdcy7aYjnXw/qJCxRP8Ws8f8w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqTft-00015Q-NS;
	Thu, 12 Feb 2026 10:11:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vqTfs-00015J-14
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Feb 2026 10:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hITgrDI55aex/ZblBrNgOJB65qWTCKGPPApNiPkRGyM=; b=jeCd7sjcGv4TAFD7ry4pRdH463
 JAJQ8pA0gFKudmsT3wln3dME/sF7Ra4y1NaDSXBAUMtWf+DHhwhDMoIITpmgqip1i7faGSh/hTZjb
 FIOU8+rK2WVUMAotDSFzwmrH30m8cGXihsFpzx7EAv+6xDka+CUrXmk9MUPL4B2+T0A8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hITgrDI55aex/ZblBrNgOJB65qWTCKGPPApNiPkRGyM=; b=i2axFbLC/vqeyGsfPVa7zQAMbj
 2FB91wY7NUeMTV9XguscyMhY11FGP1pessTxk+QRa/Eq/lXBlANldZxoz50MvdeOXwNtDVTfu8hgx
 cRPzsXsoBmC3LzZ8lDstvlebkI9ncPPv+IKqecuvdLvJKKUE9e8IYzUfZW0VyhKpywXM=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vqTfr-0005Sw-4t for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Feb 2026 10:11:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 984CA68D09; Thu, 12 Feb 2026 11:11:43 +0100 (CET)
Date: Thu, 12 Feb 2026 11:11:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260212101143.GA7951@lst.de>
References: <20260212012652.GA8885@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260212012652.GA8885@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vqTfr-0005Sw-4t
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 7.0
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
Cc: fsverity@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, David Sterba <dsterba@suse.com>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Note that this had a merge conflict in linux-next.  So unless that
went away, it needs a merge resolution like:

https://lore.kernel.org/fsverity/20260203053604.GC15956@lst.de/T/#m291294c1f6b7368d3c426ee47e6d23dc854b3ba6



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
