Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919C7D6CFC7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 05:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3f9lC5IcwUB5himzrXh1EGdYnq1/aZ2L9FlTOfa4f1A=; b=LOxlbMH9J3Bdc/GOZy6QqAkXRE
	HoDdjdKaYgyMdypNvc1EPzR/wMZScuKUarDnJO7VsME4QhqvwGyBc5pVExV8pSLacARVb94B/UZ+X
	/HUNT4hcpQ8nEamoLfSZtqJhSSXMXwFlEO8bAdVQYMXaOOJIy1lIZ73gB5QMpyxURHi8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj9Wk-0005Rl-Dp;
	Fri, 23 Jan 2026 05:16:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vj9Wi-0005RT-Mn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 05:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U2uOTnkxkWomCYUZ2W0DlL3szNoAXhoJKojyq86EGsY=; b=OpRouBPIJYL4/AoIDeu5n/MLYI
 tzt6ViK5p/YZUsJP2KWbOzkdMiMzdi307s7SCLbyJW+WufEHS84Xvubk+GQcpKfDbcqLazzTLnmGW
 8WIiJY7sJK2zU95ZyCNY7v4HVvlYANFwOaPn2AXuGqTOOab1ikYMLQDhLJjQ2CkGPyRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U2uOTnkxkWomCYUZ2W0DlL3szNoAXhoJKojyq86EGsY=; b=aF6HWQQm2I04p5amem+ywdzu7S
 AZ5HR8MhoSltbzlnZoc7a2SgomGYsVEY5ttOdhR9Y5dWRRJuRtKzZVXChMlw/XcXPCWktpj31RxX6
 4na2aHML+fOGjQHj6v8lN5vBF88MxQFEOAoSIxOu15nOqVnLodbSBdbmdeUdY5QeyZMI=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj9Wj-0006Ma-12 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 05:16:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 40876227AAE; Fri, 23 Jan 2026 06:15:57 +0100 (CET)
Date: Fri, 23 Jan 2026 06:15:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260123051556.GC24123@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-8-hch@lst.de> <20260122214958.GG5910@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122214958.GG5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vj9Wj-0006Ma-12
Subject: Re: [f2fs-dev] [PATCH 07/11] fs: consolidate fsverity_info lookup
 in buffer.c
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
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 22, 2026 at 01:49:58PM -0800, Darrick J. Wong wrote:
> Well this is no longer a weird ext4ism, since f2fs also needs this,
> right?  Maybe this comment should read:

f2fs doesn't use buffer heads.  So this is just because ext4 only
implements the easy parts of ->read_folio and ->readahead itself and
falls back onto the generic code for the rest, which then had to be
grow hacky ext4-specific bits like this for it :(



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
