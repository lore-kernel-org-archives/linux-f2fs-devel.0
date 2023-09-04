Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE327C83F3F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Sep 2023 18:11:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qdE2l-00076y-Sl;
	Mon, 04 Sep 2023 18:11:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qdE2k-00076n-CX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Sep 2023 18:11:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cAu4OpOoEvlXClCd1Z3ZHpfJMYuJmznhf5SPht9uwpo=; b=Zebw+uOsmuT5O9DheFDZM6olNi
 PzRp3L6Vz4BREuJ5J5PG0Jl4rymN4y0ca/tOHxl4SekiSJBmwN4kQX2u3fgMG/mEe3BRfYSovM/H5
 JBuTNK180VFlMRQJ8aKGHWXAblAhaOYoLyE2sfEjvdkGwASmR+1T2fQ9N8/EsgSMWQ1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cAu4OpOoEvlXClCd1Z3ZHpfJMYuJmznhf5SPht9uwpo=; b=KSmPJwdoBtQ/tj/ZsOx1ThAS9k
 2bQOYHV9logYpwWzmRZf2LTC6HebRFgeEaLz2A7NZTuUM34laAfvvMUc0F2HKEV7g44rQy7MLQqOg
 j1iiqldxQCKK07wY+he/eFCgq13SQDXkJNsVEDs7ILlgSvBRovUFBz8Gc5E7cAUWIikI=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qdE2i-009VKw-BI for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Sep 2023 18:11:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9BE26CE0F96;
 Mon,  4 Sep 2023 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC393C433CA;
 Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693851068;
 bh=KWuluqFF5yFV+lOCkFnoct0phRXw96Jca/CuZaTU2kY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=K3gkbkhJRwgpsacHeBsq0A7kucjUSGo8OzMP1ouPw/XPyf9sD5QK/Sf142+usc7ZE
 C827H7oMTO9xQURopm4EWqGoFioLBjSEY4gmbRDnvHI4L+ywXrxJRVy5ldQmRaAtfj
 1pffFi8IArgTV4dPuYUPdlhMXVuT7Hb/6kEuD4lj+4NJdrul8tjUb9OXjEUjpGn+jT
 2ndFdt5oPLx5wHtLQ20DiaB9Xl09djxp9OA/4zW9QgSOHR3JDKxABg9kMIgFr5Ox62
 wqlEdaiOf1aM8ubxkjKV3yvjnRyA83mc2npN6NfYoiPdtaZLbxGvWm4TgDkfWkglX8
 L2qkw/qB1Voxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 A2BE4C04E26; Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169385106866.19669.14483196627780303129.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 18:11:08 +0000
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
X-Headers-End: 1qdE2i-009VKw-BI
Subject: Re: [f2fs-dev] [PATCH v7 00/13] fs: implement multigrain timestamps
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
Cc: lucho@ionkov.net, martin@omnibond.com,
 almaz.alexandrovich@paragon-software.com, jack@suse.cz,
 linux-xfs@vger.kernel.org, djwong@kernel.org, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, dhowells@redhat.com, clm@fb.com,
 adilger.kernel@dilger.ca, hdegoede@redhat.com, marc.dionne@auristor.com,
 codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, hubcap@omnibond.com,
 pc@manguebit.com, linux-cifs@vger.kernel.org, ericvh@kernel.org,
 agruenba@redhat.com, miklos@szeredi.hu, richard@nod.at, mark@fasheh.com,
 hughd@google.com, bcodding@redhat.com, code@tyhicks.com,
 cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org,
 ntfs3@lists.linux.dev, idryomov@gmail.com, yzaikin@google.com,
 linkinjeon@kernel.org, trond.myklebust@hammerspace.com, sprasad@microsoft.com,
 amir73il@gmail.com, keescook@chromium.org, ocfs2-devel@lists.linux.dev,
 josef@toxicpanda.com, tom@talpey.com, tj@kernel.org, huyue2@coolpad.com,
 viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, dsterba@suse.com,
 jaegeuk@kernel.org, ceph-devel@vger.kernel.org, xiubli@redhat.com,
 xiang@kernel.org, hirofumi@mail.parknet.co.jp, jaharkes@cs.cmu.edu,
 brauner@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
 joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 sfrench@samba.org, senozhatsky@chromium.org, mcgrof@kernel.org,
 jefflexu@linux.alibaba.com, devel@lists.orangefs.org, anna@kernel.org,
 jack@suse.com, rpeterso@redhat.com, linux-mtd@lists.infradead.org,
 akpm@linux-foundation.org, sj1557.seo@samsung.com,
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, jlbec@evilplan.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Mon, 07 Aug 2023 15:38:31 -0400 you wrote:
> The VFS always uses coarse-grained timestamps when updating the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metadata updates, down to around 1
> per jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this coarseness has always been an issue when we're
> exporting via NFSv3, which relies on timestamps to validate caches. A
> lot of changes can happen in a jiffy, so timestamps aren't sufficient to
> help the client decide to invalidate the cache.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v7,01/13] fs: remove silly warning from current_time
    https://git.kernel.org/jaegeuk/f2fs/c/b3030e4f2344
  - [f2fs-dev,v7,02/13] fs: pass the request_mask to generic_fillattr
    https://git.kernel.org/jaegeuk/f2fs/c/0d72b92883c6
  - [f2fs-dev,v7,03/13] fs: drop the timespec64 arg from generic_update_time
    https://git.kernel.org/jaegeuk/f2fs/c/541d4c798a59
  - [f2fs-dev,v7,04/13] btrfs: have it use inode_update_timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/bb7cc0a62e47
  - [f2fs-dev,v7,05/13] fat: make fat_update_time get its own timestamp
    (no matching commit)
  - [f2fs-dev,v7,06/13] ubifs: have ubifs_update_time use inode_update_timestamps
    (no matching commit)
  - [f2fs-dev,v7,07/13] xfs: have xfs_vn_update_time gets its own timestamp
    (no matching commit)
  - [f2fs-dev,v7,08/13] fs: drop the timespec64 argument from update_time
    (no matching commit)
  - [f2fs-dev,v7,09/13] fs: add infrastructure for multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/ffb6cf19e063
  - [f2fs-dev,v7,10/13] tmpfs: add support for multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/d48c33972916
  - [f2fs-dev,v7,11/13] xfs: switch to multigrain timestamps
    (no matching commit)
  - [f2fs-dev,v7,12/13] ext4: switch to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/0269b585868e
  - [f2fs-dev,v7,13/13] btrfs: convert to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/50e9ceef1d4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
