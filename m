Return-Path: <SRS0=mgX/=V4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9349FC433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:39:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1CB2067D;
	Wed, 31 Jul 2019 23:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="S86Bsgi+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BPRkmQdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1CB2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsyBS-00013h-K2; Wed, 31 Jul 2019 23:39:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hsyBS-00013W-2J
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jul 2019 23:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CL5lJ5fDavnTAR09k6Pp4JtfrVuN+aNIUOfdUZWF0Xw=; b=S86Bsgi+mqqJgcjuGeHa1qYC7W
 wqtesaclf7TKGhWChMLuGW3C1GW35+h/ybP0L4ILI41Y7POIb02jQg6D5qy4XD7TwKb30ywmRWW0o
 +RUqcf1d10L8t0DV3b4T65Xan39rUxrXzLVr061HCiT7phq/yC9DIkch5yjmJixNLofg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CL5lJ5fDavnTAR09k6Pp4JtfrVuN+aNIUOfdUZWF0Xw=; b=BPRkmQdpV0Od9CHcECbe5FkAQ0
 4oTCmnZOWj2W+loPFNBcPNpVYhZYXsJV9YyI3LRUYuLbqFbRqNEoP/ubeXOBsp+gy12mCxe/RObiV
 zonBJ+hzSjeqw2PBZQhEAor5cMgDpIZsG0VuYkt79TwFNghoq0YK58hQHBITI2trbSu0=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hsyBN-005oh4-Ae
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jul 2019 23:39:02 +0000
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net
 [96.72.102.169] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6VNchZY000330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2019 19:38:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 3EE374202F5; Wed, 31 Jul 2019 19:38:43 -0400 (EDT)
Date: Wed, 31 Jul 2019 19:38:43 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
 linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
 Paul Crowley <paulcrowley@google.com>, Satya Tangirala <satyat@google.com>
Message-ID: <20190731233843.GA2769@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-8-ebiggers@kernel.org>
 <20190728192417.GG6088@mit.edu> <20190729195827.GF169027@gmail.com>
 <20190731183802.GA687@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731183802.GA687@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hsyBN-005oh4-Ae
Subject: Re: [f2fs-dev] [PATCH v7 07/16] fscrypt: add
 FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
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

On Wed, Jul 31, 2019 at 11:38:02AM -0700, Eric Biggers wrote:
> 
> This is perhaps different from what users expect from unlink().  It's well known
> that unlink() just deletes the filename, not the file itself if it's still open
> or has other links.  And unlink() by itself isn't meant for use cases where the
> file absolutely must be securely erased.  But FS_IOC_REMOVE_ENCRYPTION_KEY
> really is meant primarily for that sort of thing.

Seems to me that part of the confusion is FS_IOC_REMOVE_ENCRYPTION_KEY
does two things.  One is "remove the user's handle on the key".  The
other is "purge all keys" (which requires root).  So it does two
different things with one ioctl.

> To give a concrete example: my patch for the userspace tool
> https://github.com/google/fscrypt adds a command 'fscrypt lock' which locks an
> encrypted directory.  If, say, someone runs 'fscrypt unlock' as uid 0 and then
> 'fscrypt lock' as uid 1000, then FS_IOC_REMOVE_ENCRYPTION_KEY can't actually
> remove the key.  I need to make the tool show a proper error message in this
> case.  To do so, it would help to get a unique error code (e.g. EUSERS) from
> FS_IOC_REMOVE_ENCRYPTION_KEY, rather than get the ambiguous error code ENOKEY
> and have to call FS_IOC_GET_ENCRYPTION_KEY_STATUS to get the real status.

What about having "fscrypt lock" call FS_IOC_GET_ENCRYPTION_KEY_STATUS
and print a warning message saying, "we can't lock it because N other
users who have registered a key".  I'd argue fscrypt should do this
regardless of whether or not FS_IOC_REMOVE_ENCRYPTION_KEY returns
EUSERS or not.

> Also, we already have the EBUSY case.  This means that the ioctl removed the
> master key secret itself; however, some files were still in-use, so the key
> remains in the "incompletely removed" state.  If we were actually going for
> unlink() semantics, then for consistency this case really ought to return 0 and
> unlink the key object, and people who care about in-use files would need to use
> FS_IOC_GET_ENCRYPTION_KEY_STATUS.  But most people *will* care about this, and
> may even want to retry the ioctl later, which isn't something youh can do with
> pure unlink() semantics.

It seems to me that the EBUSY and EUSERS errors should be status bits
which gets returned to the user in a bitfield --- and if the key has
been removed, or the user's claim on the key's existence has been
removed, the ioctl returns success.

That way we don't have to deal with the semantic disconnect where some
errors don't actually change system state, and other errors that *do*
change system state (as in, the key gets removed, or the user's claim
on the key gets removed), but still returns than error.

We could also add a flag which indicates where if there are files that
are still busy, or there are other users keeping a key in use, the
ioctl fails hard and returns an error.  At least that way we keep
consistency where an error means, "nothing has changed".

	    	     	   	  	   - Ted

P.S.  BTW, one of the comments which I didn't make was the
documentation didn't adequately explain which error codes means,
"success but with a caveat", and which errors means, "we failed and
didn't do anything".  But since I was arguing for changing the
behavior, I decided not to complain about the documentation.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
