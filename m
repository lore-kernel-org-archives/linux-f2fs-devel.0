Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFCAC61DF4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Nov 2023 15:21:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r6XzW-0007DS-S1;
	Fri, 24 Nov 2023 15:21:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gabriel@krisman.be>) id 1r6XzM-0007Cu-Q9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Nov 2023 15:21:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KP9kE/qZ9mZ3UkVY03ruuvTkwENKgMzDkSDUS7WTkLg=; b=K8jCqRZOtDv/IEZnyKBNHSMex8
 XyodZUsTvPNn5y2/uKDlJWsxiv8gRK0SpSY2UCrV1oJ1pEP8OFnBYmaPsXvzyMmV7rHBcoTopaFJV
 r9yLyVi7UxUWc254kJEt2n/yUoGvn7cmBhEoVJnIEKN7tHqW1WFZ70+/YMQbxxsc6cII=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KP9kE/qZ9mZ3UkVY03ruuvTkwENKgMzDkSDUS7WTkLg=; b=dkNOt2iDIbLhqVn3eaYSZVR4nJ
 cnH+gA1NfZt8732lZl5X2Sl3iRvYRIB2T+//6eMhBKBBPrE8/BprtWFjczfPuK7CjQcSkBSJq37qr
 NxJfoR+Gl1YbjSI5K5QID3Xjs3E7ZW4K3VD+I1b1O5QvvtNQZyfx6duV5wDaPqUt9eeA=;
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r6XzD-00EODF-4x for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Nov 2023 15:21:05 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D8504000B;
 Fri, 24 Nov 2023 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
 t=1700839247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KP9kE/qZ9mZ3UkVY03ruuvTkwENKgMzDkSDUS7WTkLg=;
 b=lhD5AU7Qe1kTAfOW+1UpIAHQWuMOQ6yr2r5z/v2J0mpDrMmvWJtWs0MeE8CJJa1Y0TMoHM
 b5UFHmUnbAzpLpnIAyoa8MAgUqvT1+8Is4wSqyx4tAlWm7KX4uo+UGOG57+QANq1yaXpf0
 hisz9KIiRxt6gPrJBkvO4QrG5mpxAsztruGoKDfiJDknG5+U3HbJmGPjp1y2N14v5j5E5v
 0q69wJjdvmPKRE7O5yrBnIbPsp+YdxElXEyr1g2THU26QnV88esgweZBouIGvQXmPxl+Pc
 OOHxu4SytSoxkXYopPAcXD6Mgvs7G/Q6KBtwqNh/DNvQo0WMM9en4B4dtAT30g==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20231123195327.GP38156@ZenIV> (Al Viro's message of "Thu, 23 Nov
 2023 19:53:27 +0000")
References: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
 <20231123195327.GP38156@ZenIV>
Date: Fri, 24 Nov 2023 10:20:39 -0500
Message-ID: <87plzzgou0.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-GND-Sasl: gabriel@krisman.be
X-Headers-End: 1r6XzD-00EODF-4x
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
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
Cc: Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Nov 23, 2023 at 02:06:39PM -0500, Gabriel Krisman Bertazi wrote:
>
>> > A paragraph above you've said that it's not constant over the entire
>> > filesystem.
>> 
>> The same ->d_op is used by every dentry in the filesystem if the superblock
>> has the casefold bit enabled, regardless of whether a specific inode is
>> casefolded or not. See generic_set_encrypted_ci_d_ops in my tree. It is
>> called unconditionally by ext4_lookup and only checks the superblock:
>> 
>> void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
>> {
>>         if (dentry->d_sb->s_encoding) {
>> 		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
>> 		return;
>> 	}
>>         ...
>> 
>> What I meant was that this used to be set once at sb->s_d_op, and
>> propagated during dentry allocation.  Therefore, the propagation to the
>> alias would happen inside __d_alloc.  Once we enabled fscrypt and
>> casefold to work together, sb->s_d_op is NULL
>
> Why?  That's what I don't understand - if you really want it for
> all dentries on that filesystem, that's what ->s_d_op is for.
> If it is not, you have that problem, no matter which way you flip ->d_op
> value.

I'm not sure why it changed.  I'm guessing that, since it doesn't make
sense to set fscrypt_d_revalidate for every dentry in the
!case-insensitive case, they just kept the same behavior for
case-insensitive+fscrypt.  This is what I get from looking at the git
history.

I will get a new series reverting to use ->s_d_op, folding the
dentry_cmp behavior you mentioned, and based on what you merge in your
branch.

>> and we always set the same
>> handler for every dentry during lookup.
>
> Not every dentry goes through lookup - see upthread for details.

Yes, I got that already.  This should be "we always set the same handler
for every dentry that goes through lookup and bork whatever doesn't come
through lookup."

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
