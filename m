Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A62CC636D7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Feb 2023 13:30:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pNDC8-000326-P2;
	Wed, 01 Feb 2023 13:30:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1pNDC7-000320-8M
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Feb 2023 13:30:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OVU9+n3wSvSuANAsouaV/u270liNHHgsPlHI9v82c/A=; b=K49Wkxh2FIxBqrE4JfJPT67KHH
 tbUCAKR5tvpE1nWBG77JlNuFBEz0bP4lC/S0EWtPM1SAQC2hf4YXzNVxAROpHi7S59UFPdGajlHbi
 Agd7IgsRV84twsfK39xTuh/r4oqyBLwGDnltvpw7lQODnJqMh1KmeOFIZ4DuTExTtMBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OVU9+n3wSvSuANAsouaV/u270liNHHgsPlHI9v82c/A=; b=hmfGacWmnDDR8POkn+J2CRdAG7
 gSRYB2jJhbh1wtpZPiul3P1gob9gjU8/gcxISp+lq2af4iPMor2JQM7xqlz0L+GvfMxDMnIooB8JM
 9luahvX/t2MgOkXpEf5Q6jYTL6W7kaOzOHS2RHA8uMyNXqSo9Qj7E2oQto/jkPTd0mXo=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pNDC5-007Jpc-Ds for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Feb 2023 13:30:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A80D468AA6; Wed,  1 Feb 2023 14:30:20 +0100 (CET)
Date: Wed, 1 Feb 2023 14:30:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20230201133020.GA31902@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1pNDC5-007Jpc-Ds
Subject: Re: [f2fs-dev] [PATCH v3 00/10] acl: drop posix acl handlers from
 xattr handlers
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
Cc: linux-unionfs@vger.kernel.org, reiserfs-devel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This version looks good to me, but I'd really prefer if a reiserfs
insider could look over the reiserfs patches.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
