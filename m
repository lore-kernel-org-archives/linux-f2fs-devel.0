Return-Path: <SRS0=MGGM=V2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418D0C76186
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105F7204EC;
	Mon, 29 Jul 2019 19:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eisp5xYH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QnxmgKI9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS8QBHsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105F7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsBn4-0007Zy-JO; Mon, 29 Jul 2019 19:58:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hsBn2-0007Zq-QC
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 19:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TemuNyqTE+vVwd7aOVDDMXfXCX5fiMkqUQN5PPij8Cg=; b=eisp5xYHvHXFnqlK+Q1jRN77oH
 aVPbfUTMzUKuOFcXKe/XwBMehZTYrBG1HNeQ4lQRpZdXWLHxFDqFwylkLzpCgGoAtmO7M9Bxt96Qk
 3sxduMpMPRikFuVC402AiD0j4LV+9Urus98z127wAXGZnkJJXeIkZPYLRjqzIsDV//eg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TemuNyqTE+vVwd7aOVDDMXfXCX5fiMkqUQN5PPij8Cg=; b=QnxmgKI95SQ0sejYNHZk7DoBBL
 uD79u5dQs7E3Myx+FFafDT7nWgUoT4Cg/WrkXN2H1Eclk7yjYAKiBmCDlmdGLFwhraoNLcmSUQ4HL
 pHOIMWEpn3S6vn0uPAU60iVfPfyNReKO4n0naqLUNzxOzFaJc6EcNF/FYvAvpJqiIgrk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hsBn1-00FmR9-LX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 19:58:36 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B93BB204EC;
 Mon, 29 Jul 2019 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564430310;
 bh=MUgzS0F8d9HlQcIKk/AeINedk5YvM3Io6WjGyuY8L/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iS8QBHsmz86M34KZIw9nisCR2fm0L+w7kPLmRgKBgKMY9InqdG7s5arcER6e70Hiv
 1m2j+mTH3W8YpqEW3EcAFnbX72omhY6EUmca5vAe644L7pPOodpSDNlZw9817U4/I8
 NeTf0yKRDUJxPPPBQRoViELwNkQzTSRuae1WjtFI=
Date: Mon, 29 Jul 2019 12:58:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20190729195827.GF169027@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
 linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
 Paul Crowley <paulcrowley@google.com>,
 Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-8-ebiggers@kernel.org>
 <20190728192417.GG6088@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190728192417.GG6088@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hsBn1-00FmR9-LX
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
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jul 28, 2019 at 03:24:17PM -0400, Theodore Y. Ts'o wrote:
> > +
> > +/*
> > + * Try to remove an fscrypt master encryption key.  If other users have also
> > + * added the key, we'll remove the current user's usage of the key, then return
> > + * -EUSERS.  Otherwise we'll continue on and try to actually remove the key.
> 
> Nit: this should be moved to patch #11
> 
> Also, perror(EUSERS) will display "Too many users" which is going to
> be confusing.  I understand why you chose this; we would like to
> distinguish between there are still inodes using this key, and there
> are other users using this key.
> 
> Do we really need to return EUSERS in this case?  It's actually not an
> *error* that other users are using the key.  After all, the unlink(2)
> system call doesn't return an advisory error when you delete a file
> which has other hard links.  And an application which does care about
> this detail can always call FS_IOC_ENCRYPTION_KEY_STATUS() and check
> user_count.
> 

Returning 0 when the key wasn't fully removed might also be confusing.  But I
guess you're right that returning an error doesn't match how syscalls usually
work.  It did remove the current user's usage of the key, after all, rather than
completely fail.  And as you point out, if someone cares about other users
having added the key, they can use FS_IOC_GET_ENCRYPTION_KEY_STATUS.

So I guess I'll change it to 0.

Thanks!

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
