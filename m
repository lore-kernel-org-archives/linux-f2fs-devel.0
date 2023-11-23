Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D14AC61D85
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Nov 2023 21:52:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r6Hd0-0004Py-G1;
	Thu, 23 Nov 2023 21:52:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1r6Hcy-0004Ps-Qb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Nov 2023 21:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3YrLjUsJBUZ/bf9EaibULjJMkvXQZ6F4MemzMTeG2xs=; b=giuWqPtUKf5bhHNWKlxtZUTTAD
 Rr3sVWVBgUrbKs0j+eKKZITIz2yAvTid+mX1Q+yhUQ3TDlscRxljFxAnKZKb2nMqKMNz4ga23Ulat
 nd70zOWDy2N7CGhMAJMuS6DGyQefT5eHi79TVaUrUqXiVOgEkZW9tpeYuV1wmVa8lsgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3YrLjUsJBUZ/bf9EaibULjJMkvXQZ6F4MemzMTeG2xs=; b=LZl9VZaZPcvf7YAmFRzfZwbcZi
 pIEid7y0xekXJrfqAadgMWQVanQvN8Hi0FGw+a2Dfl7e0BbqhipBv7BJkJBkhRJHBleQDgg//YMtL
 vqx7sQQNdKfPfsqIgNm7tXrRoTwnmfgQQphhHl/OfnCN2I9smWI1Fiv35ksjJoyq33wc=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r6Hcs-00DrDm-4o for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Nov 2023 21:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3YrLjUsJBUZ/bf9EaibULjJMkvXQZ6F4MemzMTeG2xs=; b=V/sOzXqbleSNlNvhcFnifsfTSi
 LlpDm5blpb37lUsF0cxNGOlevEPrYSj+W0nDw5f71OEBej2S1XdNBcMGk45KrF3eMrH9tmGWfbC4o
 hdFEnuJXXiW70XHQokbDrwUP2kEHSks+adeTf3jkvN/ud6qKju8/Tp55UB7P4lmiRirr3FmDLwLqz
 Arg1zOnwLhCFVZ3ZzKnUAobBwMlckYxIZSiFNpEGyt88azwPTmXxypcLLkSbMEmAPNwCxGebrpWUC
 jztkZ5uRhna9SX/x0le6tswJQzWOfPWxjY6V0bQkfZe5ZDENuNOy1ZkJ02WHQzYsfCxRs4qDOY3cR
 Y2ZX5wow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1r6Hcg-002GWu-2Z; Thu, 23 Nov 2023 21:52:34 +0000
Date: Thu, 23 Nov 2023 21:52:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Message-ID: <20231123215234.GQ38156@ZenIV>
References: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
 <87bkbki91c.fsf@>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bkbki91c.fsf@>
X-Headers-End: 1r6Hcs-00DrDm-4o
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
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Nov 23, 2023 at 02:06:39PM -0500, Gabriel Krisman Bertazi wrote:

> >
> > 4. d_move() and d_exchange() would ignore the value returned by __d_move();
> > __d_unalias() turn
> >         __d_move(alias, dentry, false);
> > 	ret = 0;
> > into
> > 	ret = __d_move(alias, dentry, Splice);
> > d_splice_alias() turn
> > 				__d_move(new, dentry, false);
> > 				write_sequnlock(&rename_lock);
> > into
> > 				err = __d_move(new, dentry, Splice);
> > 				write_sequnlock(&rename_lock);
> > 				if (unlikely(err)) {
> > 					dput(new);
> > 					new = ERR_PTR(err);
> > 				}
> > (actually, dput()-on-error part would be common to all 3 branches
> > in there, so it would probably get pulled out of that if-else if-else).
> >
> > I can cook a patch doing that (and convert the obvious beneficiaries already
> > in the tree to it) and throw it into dcache branch - just need to massage
> > the series in there for repost...
> 
> if you can write that, I'll definitely appreciate it. It will surely
> take me much longer to figure it out myself.

Speaking of other stuff in the series - passing the expected name to
->d_revalidate() is definitely the right thing to do, for a lot of
other reasons.  We do have ->d_name UAF issues in ->d_revalidate()
instances, and that allows to solve them nicely.

It's self-contained (your 2/9 and 3/9), so I'm going to grab that
into a never-rebased branch, just to be able to base the followups
propagating the use of stable name into instances.

Anyway, need to finish writing up the description of existing dcache
series first...


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
