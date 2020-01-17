Return-Path: <SRS0=qGLh=3G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E12C33CB1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:56:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BCC2072E;
	Fri, 17 Jan 2020 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eULWsGyS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GqfmdFSh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH5zxBHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BCC2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1isUvH-0005oy-QW; Fri, 17 Jan 2020 16:56:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gregkh@linuxfoundation.org>) id 1isUvF-0005oq-WD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jan 2020 16:56:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mWU9I+Zj58pCSXDnBPZbfOCMGnL/j9t7N2Dm6idJyO0=; b=eULWsGySx/B/AiSdx8O1A7EUPN
 E1eDmtfMk2vriQ0Ug9+fUZi21yAceFm6jVXrZl9fpgcFSVzk64pOd/t8mkkT3NeEFvqnH8lhO/ZA3
 3Pxmra273kdob+uHb08ZNp8vWEUeF1Q/tc5xZKDlK+38UtcChxGL9KmlfING2Nnksl5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mWU9I+Zj58pCSXDnBPZbfOCMGnL/j9t7N2Dm6idJyO0=; b=GqfmdFShga6TN8D/sq394lwYl3
 CV+9vmdC6fkXQ68RAg8TH2yte+oQ1ksDPoe5sXJmfi1194rT+21lYMW4APo8sMS24pjSnqrRivfsp
 7tEVodWPPdOelpNwyIbmeWoYnFl6eOgKQIWiBwy92Z+Ko5vSoMpu5gdo4hHybf3VZx4I=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1isUvB-008OJS-II
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jan 2020 16:56:37 +0000
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE81C2072B;
 Fri, 17 Jan 2020 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579280186;
 bh=itV4GZdAwjB8Lf2mvaZRf7Z5T2MikjbR+tHNgH8x7Ho=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eH5zxBHyWnHhM0fzuTtFItQX3h3ARLC8wvey/8gEsSn1hob0N06+kjPORG7OY14De
 QrJjZUhJyLqvlTzk7np+QfUA6dQP7Pgw5pF504M0eQqDOensC73sgpHjdgT0iomyQb
 Ympq5BXzPJhTWLd5/oAA3cB4qYuWz4YWHFNxeD3Q=
Date: Fri, 17 Jan 2020 17:56:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20200117165624.GC1937954@kroah.com>
References: <20200116192008.35766-1-ebiggers@kernel.org>
 <20200117081246.GA16846@infradead.org>
 <20200117164054.GD448999@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200117164054.GD448999@mit.edu>
X-Headers-End: 1isUvB-008OJS-II
Subject: Re: [f2fs-dev] [PATCH] fscrypt: reserve flags for hardware-wrapped
 keys feature
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
Cc: Eric Biggers <ebiggers@kernel.org>,
 Barani Muthukumaran <bmuthuku@codeaurora.org>,
 Gaurav Kashyap <gaurkash@codeaurora.org>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 17, 2020 at 11:40:54AM -0500, Theodore Y. Ts'o wrote:
> On Fri, Jan 17, 2020 at 12:12:46AM -0800, Christoph Hellwig wrote:
> > On Thu, Jan 16, 2020 at 11:20:08AM -0800, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Reserve flags for the hardware-wrapped keys feature which is being
> > > worked on [1].  FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY will denote that the
> > > encryption policy needs a hardware-wrapped key to be unlocked.
> > > FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED will denote that the key being added is
> > > a hardware-wrapped key.
> > > 
> > > This reservation is tentative, and these codepoints may be reused if the
> > > feature is not upstreamed.
> > 
> > NAK.  While the feature itself sounds really useful we don't just
> > reserve format bits for code not upstream.
> 
> I disagree; saving a codepoint to avoid accidental collision of a
> feature bit is a good and proper thing to do.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

What kind of "deadline" do you have for that feature to then be merged?
I'm with Christoph here, we shouldn't be reserving bits for stuff not
in mergable state, what's the rush?

thansk,

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
