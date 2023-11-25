Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C162C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Nov 2023 22:01:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r70in-0006RO-5b;
	Sat, 25 Nov 2023 22:01:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1r70ik-0006RI-OO
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Nov 2023 22:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w22BbJzeiV5XdRVkK/jPp6/I8D2fBwuLyal6AMwg+KE=; b=ee0L6go8I7aIC7tVeKJYwGNyT3
 /q/DOP1dFzl+gbY8/aUH8QY0l/0S+BGMmsG14QuzUrnkWCQBCww0HBgxlLmhVPYWJnh3hHhkG44ZR
 jBJdLnmWYsXkgeoRw3T8iLlIq2lYSCa/Xc8/Ka74I6EXvjUTp53kNwma1JYA6Skvlg6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w22BbJzeiV5XdRVkK/jPp6/I8D2fBwuLyal6AMwg+KE=; b=R76zDpeaYVAgueGoz3w3qQkE/y
 YqLpDQmdVipOVgmWvPsxzsM4OyC51fFRnW6lXBqsGL/lafh8ZLV9SUY9UKWVBfPQJV5xFUnY1xRl9
 lh+Phou5fvNcLMvt3zgxFvURe5T5JO4u5a0tjS+zcmkbnxvBWrVKWijpqzjcm7aLFAHg=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r70ii-0004ia-6o for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Nov 2023 22:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=w22BbJzeiV5XdRVkK/jPp6/I8D2fBwuLyal6AMwg+KE=; b=QiCZ7pPBmVtTKXaZnn+lVDn6Cm
 0ZY9/4Ndamq0jcwiz2+MJu/TjCe+BfNXGPFfHF9p97+bjEtUahfNsS9vnXzSCWb2dk63NcIv6N2qW
 Vb1wlZBPrlh6XSS2wB7URt2LyMmyCM+O18AOr3k3rIbFHHhUzarDz8ORLN7STfesDoCLTm2cmlgc6
 nv5IV1VEl1qWmjlfmetJC9M00CCkWH+KRKJV2SewjR8IgiOT8s1d6W/jAf6hlFE5+7Dm/q/Am6LMP
 lOxcbYLvPQI3uU3RmBCWA3J6gPalgTA3rB8r7WitEJOwo3z8fHAUxyd97D7/imaTDhaJmOZalkmA/
 6dqV+u3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1r70iW-003CV8-2x; Sat, 25 Nov 2023 22:01:37 +0000
Date: Sat, 25 Nov 2023 22:01:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Message-ID: <20231125220136.GB38156@ZenIV>
References: <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV> <87leangoqe.fsf@>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87leangoqe.fsf@>
X-Headers-End: 1r70ii-0004ia-6o
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

On Fri, Nov 24, 2023 at 10:22:49AM -0500, Gabriel Krisman Bertazi wrote:

> ack. I'll base the other changes we discussed on top of your branch.

Rebased to v6.7-rc1, fixed up (ceph calls fscrypt_d_revalidate() directly,
and D/f/porting entry had been missing), pushed out as #no-rebase-d_revalidate


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
