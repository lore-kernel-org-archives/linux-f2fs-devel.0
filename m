Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BBBC7EE2F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jun 2023 16:21:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4l39-0001Yi-I1;
	Thu, 01 Jun 2023 16:21:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q4l38-0001YT-5s
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 16:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j8pEza/E72jJtbPZIMUCUWp7Ezh0hsVDYDT7YoSCSDo=; b=EMLIoztb0YTSd5mnIWUPoJvcPA
 VNrS723ZHYDJufJknCRAZZtzEmcik6ukRAY8sLqw3DD3NEQKWmhfUGszjk+SLFR9E0Dhutw7p4Qrf
 7k2OGsIzFOR/8MoweYzFs0RoT/FK3Rd89KoW3q7QzVlmwBtfO95xn8Qo89Ry9oMwJ2Mc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j8pEza/E72jJtbPZIMUCUWp7Ezh0hsVDYDT7YoSCSDo=; b=DNpQ2YSd/GqGdambe1TwYGwlKi
 HXy/DVXUiNstsVZn5uSjTN28h/Oi0Ei9FE4vCKvJNqZWCsW8fL/Dok9WXkLqGvhB02ByLnzr/ucQN
 /SnL531TJT432ImHpU4oJLFnw5t9DTpWplB9TVQSuiPj8RvHxTZieStAOCQOw4EZ/CcA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4l32-0002Aa-2b for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 16:21:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A7E7F6114E;
 Thu,  1 Jun 2023 16:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45044C433EF;
 Thu,  1 Jun 2023 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685636466;
 bh=J9x2GSgcCuBZSk1uZOf/tNoS5CtNSbRyWQ2pfrQq7M4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZZCqqQC0a9i9hGh1DZzervY8TO67e/jssn6MiOym0PkWTyCcyWpfLV+nzn/KctYrE
 JmIfAZQkiWDITUxLX3S0cHZd21Ufpix0t56Pt2OHQRvZHXQkCcBLhl9D/y85/SxXNk
 yI8GCS0Sym3IJxaE5pBG64Azm8xrd5iMdGu8WvDS40fu8DPjGmWji6boJV4tmXMv8U
 phMlnOqSSvBA0I4rm6Su2mcfaT4sLPUKsyLrNmGplbNqgEQ/xOVeEGTUSTxcj99tja
 YNqJQEBVbEb5Wm7RmYNxO9Bpk3zIXOfDGWvc1N7nneMMdNOWCT1ER/auVu2jvRbMkH
 3pdzyWUkOfaVg==
Date: Thu, 1 Jun 2023 18:21:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Message-ID: <20230601-flora-hemmung-31a1e66b5179@brauner>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
 <20230601152449.h4ur5zrfqjqygujd@quack3>
 <c5f209a6263b4f039c5eafcafddf90ca@AcuMS.aculab.com>
 <20230601161353.4o6but7hb7i7qfki@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230601161353.4o6but7hb7i7qfki@quack3>
X-Headers-End: 1q4l32-0002Aa-2b
Subject: Re: [f2fs-dev] [PATCH v2 4/6] fs: Establish locking order for
 unrelated directories
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
Cc: Ted Tso <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Al Viro <viro@ZenIV.linux.org.uk>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 01, 2023 at 06:13:53PM +0200, Jan Kara wrote:
> On Thu 01-06-23 15:37:32, David Laight wrote:
> > ...
> > > > > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > > > > + * in two directories, one is not ancestor of the other
> > 
> > Not directly relevant to this change but is the 'not an ancestor'
> > check actually robust?
> > 
> > I found a condition in which the kernel 'pwd' code (which follows
> > the inode chain) failed to stop at the base of a chroot.
> > 
> > I suspect that the ancestor check would fail the same way.
> 
> Honestly, I'm not sure how this could be the case but I'm not a dcache
> expert. d_ancestor() works on dentries and the whole dcache code pretty
> much relies on the fact that there always is at most one dentry for any
> directory. Also in case we call d_ancestor() from this code, we have the
> whole filesystem locked from any other directory moves so the ancestor
> relationship of two dirs cannot change (which is different from pwd code
> AFAIK). So IMHO no failure is possible in our case.

Yes, this is a red herring. What matters is that the tree topology can't
change which is up to the caller to guarantee. And where it's called
we're under s_vfs_rename_mutex. It's also literally mentioned in the
directory locking documentation.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
