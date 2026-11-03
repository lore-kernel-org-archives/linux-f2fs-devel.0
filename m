Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F443606A32E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OEVZxyqG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N3p3fgHI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f96oe36A;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxTdKS3T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RzVU0JU8L7WiwNtUsxI59+guqBTcXGgV0h6ctyALN/8=; b=OEVZxyqGn+p6Ni
	wImYpVDSDiKGtcgBoSi3EFr1Fe0ztqjA5rtgV3f6ZAGjdBC3xpzVU3YQuMzG9FRx6ksMAVw2mo7JR
	uVea+8DQTrdVg3DQCCjvFQjTKzh1JhOXIr6vTgotlK1MZBQ+JfmLtIM0EtXHwG7e18SCvLUuxOsgO
	2d4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO2jB-000000002pJ-3bHi;
	Tue, 03 Nov 2026 00:50:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xO2jA-000000002pB-3Z5C
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sQM8DOk+zZLZYMqSaPiKyghSQOh+EEtZ/OBexp3ZNJ4=; b=N3p3fgHIc5SADDOR87hP5ZxTyP
 UI8rdROh9K9VBzM20Fvj+JLuo9LS1OUsaTHTnwN+z4MTJz/cUUEr7OxFikV0YjEQW0wQ79gH91Hc0
 5tcmB3iq/DzLMQyMZKnjElYZHIuFqTwHePIFpdhCWaqeAdewMBbWdMnETD2erihd/qfI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sQM8DOk+zZLZYMqSaPiKyghSQOh+EEtZ/OBexp3ZNJ4=; b=f96oe36AlYfdsk0PvRf5oDOB0c
 F2bO1B3egZsbgCGBvhpPNMLIhQ9bxHCMVpTm0GZw/oAWHrp/09eZhvonOvxZri534bgmhx7MENVv0
 yM1cs2QFSkYec/Zwr0SqKvn7mcrpqGL8GlVz5EQXyYLVsDLqdd2CD32KvxjojzWXJf0Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO2j9-000000002MW-1poW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D13F56022E;
 Tue,  3 Nov 2026 00:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B801F000C1;
 Tue,  3 Nov 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793667009;
 bh=sQM8DOk+zZLZYMqSaPiKyghSQOh+EEtZ/OBexp3ZNJ4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=JxTdKS3T/D0H8YXeBF7xqpYwd0KtU7EE0AJG6yUYf1hvBq1FPdyBLpNi5/yG/AGoq
 EEmvDZCGxw8gboYd6u9cV5qNB/chUcuAa1BY1NY4bNZtrRfzPw00V+CpLRS9qxwl4f
 3dXD9XllocKghwTvf2WZsigIL9Z/FZUsjxiMN1Jqy68WXCkqsS7Th8vMeMkbdr4uH+
 bbpLMcmXRPKZAgFHOfWzMhjxOSYs9aeq3ZGRpI8loc+Yfut8lZzn+rZI+TCWMGsRbE
 n28NeLOmkRHTwYmgwYBiYiaT78es2aeePX8rIbZfkaiBbdVJA8q3yJkQrEp9x4RVIV
 LcCeYdKunvWrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D44B380821F; Tue,  3 Nov 2026 00:50:09 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179366700804.755181.9413256107192916599.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 00:50:08 +0000
References: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
In-Reply-To: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xO2j9-000000002MW-1poW
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix use-after-free of quota
 file names on failed remount
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
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 lihongbo22@huawei.com, jaegeuk@kernel.org,
 syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com
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

On Mon,  2 Nov 2026 10:36:46 +0800 you wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> f2fs_show_options() prints the journalled quota file names without any
> lock that excludes remount, and a failed remount frees the current names
> before restoring the old ones.  Reading /proc/mounts at that moment is a
> use-after-free.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: fix use-after-free of quota file names on failed remount
    https://git.kernel.org/jaegeuk/f2fs/c/441baab7f06a
  - [f2fs-dev,v2,2/2] f2fs: free the quota file name that remount drops
    https://git.kernel.org/jaegeuk/f2fs/c/f0d620265cbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
