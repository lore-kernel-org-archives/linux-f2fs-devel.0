Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0B9C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Nov 2023 16:03:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r7e5D-0005DV-U4;
	Mon, 27 Nov 2023 16:03:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1r7e5C-0005DN-Mq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Nov 2023 16:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WADlmt0rPTmLzYraJFSvoEJCh9ofuPI7Y7W8RJprDbQ=; b=D6mY8106Lr3crjWWw3QK8V3Z92
 MKqDh7jKFxwuMQibBNq/QkKQcbfFFCsPgEvHGZNdhTB5Ol38aGcHRBdIUmLIOAY5hQ3UTs0rCZD3A
 5mIsjJSMnhNv7A+2tpNK3n7JoxjUkqEz89roOH1kMyxKa3oLPK88PlkpZ4OY2FKVDByA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WADlmt0rPTmLzYraJFSvoEJCh9ofuPI7Y7W8RJprDbQ=; b=JBej4UkKNz2hfotkWAQxyhlw3y
 sYvT9RsVxKInRkGk9WVRNar5u8Mxaz4h1XwQUiVXp1GiDu6lenXu8W76a5p84zsNQYgeAJlMZn/qb
 zkWlz4QiaE3wA7V9n8Aiue3ZExCpiB9kYSKcXVTLd7emXKilI087qJ7C5IdSmpbU1vw8=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r7e59-0001QZ-4V for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Nov 2023 16:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WADlmt0rPTmLzYraJFSvoEJCh9ofuPI7Y7W8RJprDbQ=; b=Akrn0yg6UNfIbJGcGj1gbFDffH
 QIiDenv6JZ2RDn2pjA3OeCYK75MjVSpT4f2X6lA/UZKayOJUfNFTOyOqNWjJzMvRwrBNZcEsgt0/J
 jD6Zfk0Woz1EEiCu7CFCexbj37ld5f/45w9CVV6O2VycoKwHfXou96aq/2M5/GBNMC9cCcMMkVXhe
 7XSB7xEOXzp6paAz/XeQihFCiS9dOcIRw41n0mjMSS5hE5s0PwUs1zMVYSYlu4ofsbG0cxgd3XZUN
 aX18iCmp3A46c0raVJMvy813mkyebxJz9qOFukVDVQcXgOuMPDcooXx9aQd0ADW3mgYc1+kCLit3j
 UN3GesQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1r7e4s-0042ow-0w; Mon, 27 Nov 2023 16:03:18 +0000
Date: Mon, 27 Nov 2023 16:03:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20231127160318.GI38156@ZenIV>
References: <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV> <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV> <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
X-Headers-End: 1r7e59-0001QZ-4V
Subject: Re: [f2fs-dev] fun with d_invalidate() vs. d_splice_alias() was Re:
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
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
 Miklos Szeredi <miklos@szeredi.hu>, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Nov 27, 2023 at 09:47:47AM -0600, Eric W. Biederman wrote:

> There is a lot going on there.  I remember one of the relevant
> restrictions was marking dentries dont_mount, and inodes S_DEAD
> in unlink and rmdir.
> 
> But even without out that marking if d_invalidate is called
> from d_revalidate the inode and all of it's dentries must be
> dead because the inode is stale and most go.  There should
> be no resurrecting it at that point.
> 
> I suspect the most fruitful way to think of the d_invalidate vs
> d_splice_alias races is an unlink vs rename race.
> 
> I don't think the mechanism matters, but deeply and fundamentally
> if we detect a directory inode is dead we need to stick with
> that decision and not attempt to resurrect it with d_splice_alias.

Wrong.  Deeply and fundamentally we detect a dentry that does not
match the directory contents according to the server.

For example, due to rename done on server.  With object in question
perfectly alive there - fhandle still works, etc.

However, it's no longer where it used to be.  And we would bloody better
not have lookups for the old name result in access to that object.
We also should never allow the access to *new* name lead to two live
dentries for the same directory inode.

Again, this is not about rmdir() or unlink() - invalidation can happen
for object that is still open, still accessed and still very much alive.
Does that all the time for any filesystem with ->d_revalidate().


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
