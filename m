Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6BDD3566F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNTpcyWxaPliXtNdbx/4M+SeV0pmAfyLZbA5HRTfjLE=; b=atwNQJr2xArP72Lcz/Aogf+U7j
	TlfvKS4eOxlRw2hFvKr9fSEu17UvPCKqcYwQpHmLzsknf/Le2RsfIUlolYW5uSqNOJfpg3cnNiHxb
	y19AEkVMVNrlvmmc4ssfH5BYHpGrukVszTogiFx7Wsafw4jwC0hQY1epTkbI+s+uh59I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkwXI-0002pB-QI;
	Wed, 28 Jan 2026 03:48:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkwXH-0002p2-PO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A2rlbOe9c7YoIfneu2bs850V19E9Gp9LDdwFcT7kMQU=; b=Q2nzTTIAfehVZYvwNBZ+fHCVoh
 63aktdhq+YVt7ZV+eAWruxKBrstJj0I+XVM79D4lwCSYAgubh6ijB2cpLrhPKEZX7a7Kn6lfUyqrN
 /P8CvIVlD1oMZw2otZIaLetxkWS4Yasux+vqJh3Hk0BHpyYSmqWbTEtlKWw3seIFK+YQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A2rlbOe9c7YoIfneu2bs850V19E9Gp9LDdwFcT7kMQU=; b=dP4rVxeL9CX/cekQfBd8sTSM9N
 w7Swu3j2aO+3G4VCCbihCvS2F+jCCEgU6gMC9wUpfN4VCqzc34e0EtcLjPhqgM1cYpbl/KArSAih1
 sklPkLFGCK2AVEHDPl7J2BeCJd5JWIOXlMYgtFNNxG0Mw8YxTp3rU8dzUYml0Q/llvwo=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkwXH-0001K4-AS for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:48:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 38E61227A8E; Wed, 28 Jan 2026 04:48:00 +0100 (CET)
Date: Wed, 28 Jan 2026 04:48:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260128034800.GA31178@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-10-hch@lst.de> <20260128032203.GA2718@sol>
 <20260128033242.GA30830@lst.de> <20260128034102.GC2718@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128034102.GC2718@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkwXH-0001K4-AS
Subject: Re: [f2fs-dev] [PATCH 09/16] fsverity: constify the vi pointer in
 fsverity_verification_context
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 27, 2026 at 07:41:02PM -0800, Eric Biggers wrote:
> two different directions.  Maybe just drop this patch for now?

Sure.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
