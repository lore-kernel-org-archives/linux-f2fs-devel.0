Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A9606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Nov 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XkoorT+/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=auE8IhMV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AuHf1z5I;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asgtto/P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ybTfvSP2uvcaPSmjMq0KmqCVu9qbO+jwvXjwqagHHGA=; b=XkoorT+/82q6q5aiekY456D7aT
	1/sr9D2HlTSb7CMDFkRxjZ7phOMDbxatjuZ7pzw/wUmTDflIlRnMyweIKy2zh5kXQ6a6GLBcYvtPm
	CatHHKYGqKbfWVHrmI/1mZuhACXidf93UJshsm5by7JMeNy4Jyl7lubRf1NRuaADGDJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUrth-00000000763-2rgI;
	Sat, 21 Nov 2026 20:41:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUrtg-0000000075w-1blo
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 20:41:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hmRMq/jyaz6ubqP2Q/8QAmwoitBfjKyHf2qlq73z/v0=; b=auE8IhMV7WIPMWLwpDH8L9CU2c
 TddMbGc7sXSq5a/2P04GLkeVeSSAAbypo3RIVElbHlxPpfX39GHJ04G7+Lzq8kH9rSAnCq++N4uVy
 ztCYxVbCpXrH6oEPtyQsU+M7jJUlrbeUKlkfV2jCelV0qrmz7njb2T3SD/9g6V7FY8Wo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hmRMq/jyaz6ubqP2Q/8QAmwoitBfjKyHf2qlq73z/v0=; b=AuHf1z5IzDZh1+3cEFHXE+xy2a
 ihSWQ02jtnhO8Hhr8jJNl9PSq1wL7eYnLQ1WOKVGxJs7awDgT2Zb66mrq1By7fFQnAR/Skf3CR/qV
 nsdDBLte1exPJPO7RIcuddG9DE0tYt5cX6F0h7ezWtdaObBiMU4A+At1tob/6MNPTk+s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUrtf-000000002Ib-3wCM
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 20:41:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B7FA611B6;
 Sat, 21 Nov 2026 20:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C82C1F000C0;
 Sat, 21 Nov 2026 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795293674;
 bh=hmRMq/jyaz6ubqP2Q/8QAmwoitBfjKyHf2qlq73z/v0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=asgtto/P/mqBPw1Axj+fEFZsvYqeSF/ZmIFH4PnCav4vjk1EbTjJ0mTk50wXzXd3A
 0oPFL4L3Soh2pKh6TNWZ0JSsVbLH0ArdhUWSpj9CqFwFPmMUVqG1r5h5vC44+KPoXl
 IR2BtKSF+byzNkv20T34sbwoIxBfP2Au8bsE80sR6c0kF2VA8MPzCvevXGiZgqVo4c
 Ih2S1i5XOt/camX8d7qFp4AF4rSFWnUSEIfOE7Bamymi/uFcvttZy8TP3iTO4po1sD
 USsdPvR/w9Ks6xkidDC065RYjoqD8Vpq4iibvN1DrVToa1VhYtqvYCgR9ESKu7c95F
 yRPPqnQHCa93w==
Date: Sat, 21 Nov 2026 21:41:08 +0100
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <awFTapiR9KK9H6PC@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261120155032.187246-1-aalbersh@kernel.org>
 <20261120155032.187246-5-aalbersh@kernel.org>
 <20261120222302.GD3048696@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261120222302.GD3048696@google.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUrtf-000000002Ib-3wCM
Subject: Re: [f2fs-dev] [PATCH v3 4/7] iomap: use fsverity_is_building() to
 check for fsverity IO
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity <fsverity@lists.linux.dev>, Christian Brauner <brauner@kernel.org>,
 tytso@mit.edu, linux-f2fs <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 viro@zeniv.linux.org.uk, fsdevel <linux-fsdevel@vger.kernel.org>,
 jaegeuk@kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-20 22:23:02, Eric Biggers wrote:
> On Fri, Nov 20, 2026 at 04:50:26PM +0100, Andrey Albershteyn wrote:
> > As fsverity inodes are read-only, the only write IO happening
> > during I_VERITY_BUILDING is fsverity metadata.
> 
> I think this is not accurate?  The inode is not a "fsverity inode" yet,
> and it can still have dirty data in it that is undergoing writeback.

XFS flushes data folios in _begin_enable(). Make sense for me to
have data stable on disk before starting the build, if any error
happens in data writeback we won't spent time building the tree.
That why the warning below.

But as I_VERITY_BUILDING exists now, I don't think there's
requirement to sync data before starting the build, I will update
the comment.

> 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 6d843b168d5f..0a176741e7b0 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1930,7 +1930,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio,
> >  	struct inode *inode = wpc->inode;
> >  	u64 isize = i_size_read(inode);
> >  
> > -	if (wpc->iomap.flags & IOMAP_F_FSVERITY) {
> > +	if (fsverity_is_building(inode)) {
> >  		WARN_ON_ONCE(folio_pos(folio) < isize);
> >  		return true;
> >  	}
> 
> This function no longer needs the 'wpc' parameter: it can be passed
> 'inode' directly instead.

Sure, I will update it.

> Sashiko also found an issue with this change.

That's related to my response above.


-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
