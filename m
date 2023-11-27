Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBF2C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Nov 2023 17:26:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r7fN5-0003JL-QL;
	Mon, 27 Nov 2023 17:26:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1r7fN3-0003JE-8S
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Nov 2023 17:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Z43JYeJALNXrDXAND8tVgEUdl1r9pBa63R4laSFKqM=; b=gL6qf7gaHDEkwoezWOzYgiX23y
 2Ai3rah1y4uXeIZn2/sIfgS6WLA5AlOvRG6GfClV1MlBgNROiDc1yChv0AYMG/ObFPvpbfuzf15ny
 S0OgWUu5j5TTUzcRmNDu9Ze44zDQLHVaOFgarf3me+FcGAB5mZVF+1hKCkMqYEZr+bOU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2Z43JYeJALNXrDXAND8tVgEUdl1r9pBa63R4laSFKqM=; b=Cn1DjPx32jylRrMc56e1nHkVvr
 nZDew6qSp0ZgIylJ5cXF46NHeaJ5ihbT6ZTQfAnZ+noclOX+hj/eqk8IAWeu140A0Xb0EPo2zjxIa
 EL3TZa6hbALyeU+lXrkDuTR0qe+klgBLUofxcUFkiv1KsBhOES2oq2w+fIx21UfAlQco=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r7fMw-0005gT-AV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Nov 2023 17:26:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2Z43JYeJALNXrDXAND8tVgEUdl1r9pBa63R4laSFKqM=; b=gw1zVvuh8EL0p0oUze6hyvfNHv
 Q1k2kELI/tfU7FJvRftUSSYminTgjCUIyV8flY8/cy8AzeaDI/GwgLF8WBRC1sZ9Y9b2XP7Vj1Wz6
 5BEsDmiJxnj47A0QtB4nkww+jX4+7m1XfXiOD09D6LKlUsSVnEmB5quKvuFxWw6CQM2HKNsRXlJxh
 B1A8qX/Sd2t2K8HFLjkg1Vf22wP4cqc8vcVsK6y4yjiXrZxR8ouzDufbLmcs/7Zs8BqKvAoRLxukV
 7eXR8oTigPqum+b1duZbOcxp7xbIMEhx3+SNnHil8qVpPk4mqdnWFUcIZWwSRK8orVQl4ijuSQ7AD
 zTIiRkHg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1r7fMe-0044ay-0E; Mon, 27 Nov 2023 17:25:44 +0000
Date: Mon, 27 Nov 2023 17:25:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20231127172544.GJ38156@ZenIV>
References: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV> <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV> <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
 <878r6jnq1t.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878r6jnq1t.fsf@email.froward.int.ebiederm.org>
X-Headers-End: 1r7fMw-0005gT-AV
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

On Mon, Nov 27, 2023 at 10:01:34AM -0600, Eric W. Biederman wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> 
> > I am confused what is going on with ext4 and f2fs.  I think they
> > are calling d_invalidate when all they need to call is d_drop.
> 
> ext4 and f2f2 are buggy in how they call d_invalidate, if I am reading
> the code correctly.
> 
> d_invalidate calls detach_mounts.
> 
> detach_mounts relies on setting D_CANT_MOUNT on the top level dentry to
> prevent races with new mounts.
>
> ext4 and f2fs (in their case insensitive code) are calling d_invalidate
> before dont_mount has been called to set D_CANT_MOUNT.

Not really - note that the place where we check cant_mount() is under
the lock on the mountpoint's inode, so anything inside ->unlink() or
->rmdir() is indistinguishable from the places where we do dont_mount()
in vfs_{unlink,rmdir}.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
