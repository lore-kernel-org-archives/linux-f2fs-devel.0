Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAC60895AE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ni3JGRUO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XgXe7jh+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D/na5lDG;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFUvlfXr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ao4IF3jm0Ko3aVI7wxG5VBMTTf2NagZwZYTpdAGoTK4=; b=Ni3JGRUOVpaHEn
	0a1Nr952NRG/U6v+QwGEqmLXXh3BVzHwQMIB2t3P3IQvinOBYoGf0zDnO3alysFBJhpHE+44t8iaF
	OYapS02WE2lpKQoLQnTUI/IaU5o+LGv8fQfsAJ2z4j/uFGnVoxxh+dPrvkk82rkSX2IX5WjnekMQY
	Wfo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNuvO-000000001Hh-25k6;
	Mon, 02 Nov 2026 16:30:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xNuvL-000000001HZ-3776
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u+ZLLWZ4r7BpZicgUhx1wwDWmMzDYFFNM7vGJnHJh+k=; b=XgXe7jh+UCFSO1AGsoew1kzitC
 4w+02h/03mluYpAQhN+CQXloBLphZK3O/XePDSRBobCYIuqqdJ1DtHf6AwDCcQ4pTS50jN0dhvH4S
 UR9FPkPX253oRhyfzqIQzCFfm2UilE7Lo4JdpcDD9XyoBfrajtJSzVQMr9qx8cqXMaAk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u+ZLLWZ4r7BpZicgUhx1wwDWmMzDYFFNM7vGJnHJh+k=; b=D/na5lDGajXCcK9SR90RC/uyB+
 tqhGOckpHKTtzvhHJX/vvadABeL9MOW9ucQm4CD7STniegDDT8n1INigvGfb7a+lFetoRfdn9GFON
 vycW1YUKYIF6LNCPs9ygfrIGsh2Kdhv2QVV5e93yCrn7fbBDL2+0zXiUWDaaQCNi2ljQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNuvK-0000000057s-282I
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D69B360628;
 Mon,  2 Nov 2026 16:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897AB1F00A17;
 Mon,  2 Nov 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793637012;
 bh=u+ZLLWZ4r7BpZicgUhx1wwDWmMzDYFFNM7vGJnHJh+k=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=KFUvlfXreI/MoxmoSkPqRVVzpDpd+uTzijNwa8+nsJnOKBxyUIALDZfVL0WBbBBPj
 apXZ4IRU2ZDF1FKiRTg+XpBv6d2hZgmbJC1YCGAk+9XspdFs7Flf7LvAb4XbcI4dEt
 PWQ60lvtUmio4oCfst8VG67gqd4zA8RKAK7PfnEMfZVaHZDLuXxJ0GUXYOfnhio45C
 YgaewouNkMZK+nFuScSYlySYr4USY/Ny+3YTeKLGMbHpNu4JbHhRjA3aUq6bJaPucn
 ptwJRYNHzt9h4z6cDQEAdCXo515zsTmJx9W/kbzkYhhTz5vLzARb6mhFLL0UADkRx6
 mP4H7FRx2rsug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D265380821F; Mon,  2 Nov 2026 16:30:12 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179363701099.39295.7655811180545281360.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 16:30:10 +0000
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNuvK-0000000057s-282I
Subject: Re: [f2fs-dev] [PATCH v3 00/17] f2fs: support & optimize large
 folios for writable files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: baohua@kernel.org, nzzhao@126.com, jyescas@google.com,
 daehojeong@google.com, linux-kernel@vger.kernel.org, Dev.Jain@arm.com,
 David.Hildenbrand@arm.com, linux-f2fs-devel@lists.sourceforge.net,
 zhangbo56@xiaomi.com, kaleshsingh@google.com, jaegeuk@kernel.org,
 lipengfei28@xiaomi.com, Ryan.Roberts@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 10 Oct 2026 00:12:07 +0800 you wrote:
> This series supports large folios for most readable/writable files
> in buffered I/O paths, including normal files, block-layer encrypted
> files, and atomic files except for inline-data files, compressed files,
> and quota files.
> 
> It also extends f2fs_folio_state to coexist with f2fs page-private
> flags and to handle large folio write path and partial truncate of
> large folios correctly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,01/17] f2fs: extend folio state for large folio write path
    (no matching commit)
  - [f2fs-dev,v3,02/17] f2fs: carry subpage offset and count in write IO
    (no matching commit)
  - [f2fs-dev,v3,03/17] f2fs: support regular file buffered writes on large folios
    (no matching commit)
  - [f2fs-dev,v3,04/17] f2fs: support atomic file large folios buffered write
    (no matching commit)
  - [f2fs-dev,v3,05/17] f2fs: support large folio writeback
    (no matching commit)
  - [f2fs-dev,v3,06/17] f2fs: account large folio dirty data at block granularity
    (no matching commit)
  - [f2fs-dev,v3,07/17] f2fs: remove mappedtodisk flag usage in mmap write path
    (no matching commit)
  - [f2fs-dev,v3,08/17] f2fs: prepare mmap write faults for large folios
    (no matching commit)
  - [f2fs-dev,v3,09/17] f2fs: make GC migration large-folio aware
    (no matching commit)
  - [f2fs-dev,v3,10/17] f2fs: optimize small block size large folio read
    (no matching commit)
  - [f2fs-dev,v3,11/17] f2fs: support partial uptodate large folio read
    (no matching commit)
  - [f2fs-dev,v3,12/17] f2fs: handle partial truncate of large folio dirty subpages
    (no matching commit)
  - [f2fs-dev,v3,13/17] f2fs: wait for folio writeback before ffs_detach_free
    (no matching commit)
  - [f2fs-dev,v3,14/17] f2fs: fix zeroing paths for large folios
    (no matching commit)
  - [f2fs-dev,v3,15/17] f2fs: handle block cloning within the same large folio
    https://git.kernel.org/jaegeuk/f2fs/c/25076e575f0e
  - [f2fs-dev,v3,16/17] f2fs: allow large folio support to writeable files
    (no matching commit)
  - [f2fs-dev,v3,17/17] f2fs: make compressed files compatible with large folio
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
