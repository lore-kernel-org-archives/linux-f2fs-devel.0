Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA0CCD98E6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JcmKk0t0RyFAMvxxAriFNRTv34Ds8EaYMcd3WVzVQlE=; b=Dw7Ywu/hJUeO5b18BdPN8gEsqo
	BX/6CbErMki4779XjRO9VM63vyH0hSErVKPLZ2xuf6+qAfaLo+Iev2CdZXBa3RZdRcp7TqwPiUKXW
	QTJUXmUwETasZxORAGNV0CGaDg/Lf8BFGBik8/Cq5jaI9qk25UrqxzCwZa8lgk5+rkfE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZJsr-0004sC-7z;
	Tue, 16 Jun 2026 02:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZJsb-0004rv-67
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4CRolQFZqiuPIGjOGrXOUVnUaGrEru2dBPwV8+UKm6E=; b=dzh3y/YdzXO2FO8krH0dtQ+8dV
 dYIFPNQjHCmVGIUn2xRAKKuxiWIw5GJeMab23IG925mpQBiTyYpwx7mBBL5AnljfboG+fBpfT9w3j
 LDwIIG7gRaTXdZQ2WBbeizpPOdHmzLkzKCivDvcAZShOeV4JtJbR9z3xTjweP2rtYxmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4CRolQFZqiuPIGjOGrXOUVnUaGrEru2dBPwV8+UKm6E=; b=D
 VG0O2EKhFDpNbMlaHZCxy7thsZBzJzOd6YJiDiWRhPd+GyQeaLDlffkQ2Q/MzPzBJS/HN1aI8dcTp
 q8MqJiSgx5qscf2RsJB2QNIbxTCz1ve7r+9MYk48ZeIzjguSlWO6uiR+jmYo/QYjWjCIFVE9P17Ls
 QpjpxXaL44T9ESVs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZJsZ-0008Oy-Vq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 200C6401B4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 02:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050721F00A3A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781578210;
 bh=4CRolQFZqiuPIGjOGrXOUVnUaGrEru2dBPwV8+UKm6E=;
 h=Subject:From:Date:To;
 b=e3GuOAvpU6NG5dleAuq7/PPFyT7oEULnn6Xu4JKKsQyCqF+GkWcyIbsnP4k7wJXzx
 6zs32kaGvhjqIsmS0h9YrnJbS3EaDJtnKc3p+irvJ63hTUY25wZgJ1/U7xAI4+0iBA
 xWhQzXDYAYMxqy5RfmkZQjGQNzgbTOlgO5AZJ3MVRp6hsdyda3ZmCQIeokmZRAipJi
 wseMzu48cZi26su4jsaHKZI1FFG88grONv7a1rsl+SJe9qMffy/bg8r+OPc4mmUFVW
 V9aV+6uw6w8XDSXBTf9FwQ2d+7836nwl5HjpuNwfLkv3O8gIM5sZN32mS90jnjPTIn
 XrXhSbEzuColw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1C2E63839A26 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 02:50:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178157820464.407856.13053681331173030896.git-patchwork-summary@kernel.org>
Date: Tue, 16 Jun 2026 02:50:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wZJsZ-0008Oy-Vq
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: validate dentry name length before lookup compares it
  Submitter: Samuel Moelius <sam.moelius@trailofbits.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1105441
  Lore link: https://lore.kernel.org/r/20260603161127.17464-1-sam.moelius@trailofbits.com

Series: Reduce the time spent in interrupt context
  Submitter: Bart Van Assche <bvanassche@acm.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1109509
  Lore link: https://lore.kernel.org/r/cover.1781119949.git.bvanassche@acm.org
    Patches: [f2fs-dev,v2,1/4] f2fs: Prepare for supporting delayed bio completion
             [f2fs-dev,v2,2/4] f2fs: Rename f2fs_post_read_wq into f2fs_wq
             [f2fs-dev,v2,3/4] f2fs: Split f2fs_write_end_io()

Patch: [f2fs-dev] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
  Submitter: Bryam Vargas <hexlabsecurity@proton.me>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1110421
  Lore link: https://lore.kernel.org/r/20260611-b4-disp-155e8807-v1-1-5d14dcc72b15@proton.me

Series: [f2fs-dev,1/6] f2fs: fix wrong description in printed log
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1111704
  Lore link: https://lore.kernel.org/r/20260615130822.2576088-1-chao@kernel.org
    Patches: [f2fs-dev,1/6] f2fs: fix wrong description in printed log
             [f2fs-dev,2/6] f2fs: misc cleanup in f2fs_record_stop_reason()
             [f2fs-dev,3/6] f2fs: avoid unnecessary sanity check on ckpt_valid_blocks
             [f2fs-dev,6/6] f2fs: remove unneeded f2fs_is_compressed_page()

Patch: [f2fs-dev,v2] f2fs: reject setattr size changes on large folio files
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1109339
  Lore link: https://lore.kernel.org/r/20260610143735.3169935-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev,v3] f2fs: validate ACL entry sizes in f2fs_acl_from_disk()
  Submitter: Cen Zhang <rollkingzzc@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1111512
  Lore link: https://lore.kernel.org/r/20260615071954.4118409-1-rollkingzzc@gmail.com


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
