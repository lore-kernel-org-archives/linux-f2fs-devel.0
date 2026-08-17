Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1513C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wBY62wNGTBPsLrbUpkW/OFeMujTK8mE+A9puxXE6uv8=; b=czrkvKzfKKZE64XFSIGCTGfQrt
	c59lVgLS3CNTZD02QwlYsde4Sr3klq2GUkE5kuT36w6Ox/A2bKPuu7yh+Xyzgqx5J0/YBBV3+t2p3
	Jj4hhmFdOXtm/Ez4KpenKHOQvoEpFXpTLMq0dWjVdfMZAptFxtibb9Je6R4Gju3C/yu4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvtO9-0006dc-Ca;
	Mon, 17 Aug 2026 09:12:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wvtNq-0006dA-WD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6cNv8eSuPVrrI1XugrHa1AwCFxIYfhwh9H2h3hF/0L8=; b=J3f5ID1GkYvJuz2GAo3Fo9Knaz
 k/OhBSQDbT6abB6Bor58xIcwnHFkEPQtnBZi0tMEAXA3qFSwONod4lsmZGGaqx94iQBXheJndK7iR
 pkmXGocILiIvipC4szPdgGfxh+GmJ0OH//5dPi3s6+lmH7OL0extpDRqE3AKz0pXYPv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6cNv8eSuPVrrI1XugrHa1AwCFxIYfhwh9H2h3hF/0L8=; b=M
 dzfPpz4cwQKztMznq928ACDaxI8i01xom1s4IAM3q8uhBY89s7kE9xITql3tlzIP/3l+8pzpDiO7U
 eM+8Y59+uegiXxUY7TI/mxlaBdEdprGGsDevifMc4Zzt8y3fhcj+9LqRoKXirROJEk8smw0shVprK
 324tbio9TSaXnLSk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvtNq-0004sR-Jv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:11:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CD24419E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 09:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1241F000E9;
 Mon, 17 Aug 2026 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786957909;
 bh=6cNv8eSuPVrrI1XugrHa1AwCFxIYfhwh9H2h3hF/0L8=;
 h=From:To:Cc:Subject:Date;
 b=GyGsDrtdu4SHvMv3R2AlBECoqg65HSzMJYIi18nZFqraVATssPH3SecawzMIsspC/
 Trp6USE4juPI5kZLttMZtsXqTZIokz4fDNkiVywqievdHuW0Mgn1HA+XCP70NO1C1J
 lT7mS9K1FljENcpx3qpW7kjvV+45EVUwcB1KsMJAKPBFUtw8NyRKkRxgTwbsfbLI90
 tE1MHW09TvED01YXDTX3PdQGAikuHK2wNwymahTJJ5vX05ZQi27z5JubN2CnvFnlO8
 yYtVgU09CRPQ9aVc9CuoIjai83Gq+9gvw7rDU1o50VUp2g+YT1igoPU6FBPmax/+Vg
 JXyERlDy0SBfg==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon, 17 Aug 2026 09:11:37 +0000
Message-ID: <20260817091137.1503208-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wvtNq-0004sR-Jv
Subject: [f2fs-dev] [PATCH] f2fs/009: fix race condition in orphan inode test
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs/009     81s ... [failed, exit status 1]- output mismatch (see /share/git/fstests/results//f2fs/009.out.bad)
    --- tests/f2fs/009.out      2026-06-12 08:46:32.819432390 +0800
    +++ /share/git/fstests/results//f2fs/009.out.bad    2026-08-17 13:09:35.000000000 +0800
    @@ -1,2 +1,3 @@
     QA output created by 009
    -Silence is golden
    +can't find corruption
    +(see /share/git/fstests/results//f2fs/009.full for details)
    ...
    (Run 'diff -u /share/git/fstests/tests/f2fs/009.out /share/git/fstests/results//f2fs/009.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing f2fs-tools fix:
      958cd6e fsck.f2fs: support to repair corrupted i_links

f2fs_io write ... atomic_commit ... 5000 runs in the background and has
an initial delay before invoking F2FS_IOC_START_ATOMIC_WRITE. Without a
sleep in the test script, rm and _scratch_shutdown -f run immediately
before f2fs_io enters atomic mode, causing f2fs_io to fail and
preventing the orphan inode from being committed to the on-disk
checkpoint.

Add a 2-second sleep to let f2fs_io enter atomic mode, record its PID,
then shutdown -f to ensure the orphan inode is written to the checkpoint,
and clean up the background process properly.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/009 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/f2fs/009 b/tests/f2fs/009
index afb3bc98f..df8bef96c 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -106,10 +106,14 @@ check_links 0 0
 touch $filename
 ino=`stat -c '%i' $filename`
 $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
+pid=$!
+sleep 2
 stat $filename >> $seqres.full
 rm $filename
 _scratch_shutdown -f
-sleep 6
+sleep 4
+kill $pid &> /dev/null
+wait $pid &> /dev/null
 check_links 1 0 $ino
 
 # hardlink
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
