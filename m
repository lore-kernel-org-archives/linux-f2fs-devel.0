Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9E8C79F82
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WPUzQblfl+lt/9WOZaaWDn4T8w7bPDLArw6sEXWYhCg=; b=e2Yf2QIPm6HIjFbNE1IgjK9P0C
	2aq715LNQ9RsqKwtp1jOQstOjKmXmmH0SMlBbgjfPKwb8c9AtZJ7cGdO5NeRD1TmQxIOHFY21jKOO
	VHxR+ialwFoSvsBumRNOyWTgP2RS4ki3sfpORNLZlduMRwSTkWgMhwYop29XZKPNVVtM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x420b-0000jZ-So;
	Tue, 08 Sep 2026 20:01:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x420H-0000jH-6Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 20:01:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FnQIJ1NfvYgm84pjC5O+zBpjbtzfl4gaaU/Jza7/oVU=; b=DjYEoz3ilSUBcG20PT83ZT+sAD
 TBHFycy1MYPOKTzuODUjy6+aJoKqn8E5LQC3lXYOHxxsvMy+pgof9GupL4PheKjLeNG09a6ULn7pQ
 WvsoUBfdOBXOzrHmzWhh1qTCATmPl2IrKEQ9FMianVwu/MpV9bpbKtJ5c8MuNsj2ZQos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FnQIJ1NfvYgm84pjC5O+zBpjbtzfl4gaaU/Jza7/oVU=; b=G
 m70FdVq/5gIogtCuUXusYLTFvDU7PjN3efPPEsNRSv0aoPEY1TJga4YkRCLMgJnpkSM5BciJSw3iF
 hsipgXkl7qQhg2RhZEtmwnj7NDG6gxVVwOXB3rBY4cCYl9g10zucXC91RnQLrC68EE1hMSuihGllK
 r6ygHK/8IMHJywss=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x420G-0007Av-7I for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 20:01:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD80742E8D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 Sep 2026 20:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22971F00A3A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 Sep 2026 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788897666;
 bh=FnQIJ1NfvYgm84pjC5O+zBpjbtzfl4gaaU/Jza7/oVU=;
 h=Subject:From:Date:To;
 b=fZwKktRbB87mfXQG/sp9Rsv3i506OGlebYZ6WVT9Y/Bm8fT2L9tsGyGWAUGnkBG/Y
 G31I2+nVFB8M0lQoK4xWRrGebi+0VhfW/Hq2OAHz20WKvETKsFJmbjm4I14idsviDn
 3KnV41Jxz1ByKfalaa+o6gc199KPlOAR9JTHKVczbtk36wOyIilzx7VANBq5S46+js
 zpQu6f3CiOvy9TlXEIvdMi+HZKzsMT6TW4HNXsAgv5dSqjGtyMrDPMX9QweV2Kjb+4
 zxWR9TfZrlocKhyehVLnpKfu8uVhQcFaSLQ+HyovDgnEIEQekC8AxwRL9uppVDGbNg
 fyx3OUnMSUs+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 73F8B380820D for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 Sep 2026 20:00:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178889760531.3720652.16414069909701208505.git-patchwork-summary@kernel.org>
Date: Tue, 08 Sep 2026 20:00:05 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x420G-0007Av-7I
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

Series: f2fs: prepare metadata layouts for runtime block sizes
  Submitter: Kelvin Zhang <zhangxp1998@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1157467/
  Lore link: https://lore.kernel.org/r/cover.1788479509.git.zhangxp1998@gmail.com
    Patches: [f2fs-dev,v9,01/11] f2fs: initialize sb_info early in f2fs_fill_super
             [f2fs-dev,v9,02/11] f2fs: describe SIT block layout dynamically
             [f2fs-dev,v9,03/11] f2fs: describe NAT block layout dynamically
             [f2fs-dev,v9,04/11] f2fs: describe orphan block layout dynamically
             [f2fs-dev,v9,05/11] f2fs: describe dentry block layout dynamically
             [f2fs-dev,v9,06/11] f2fs: describe {i, d, id}node block layout dynamically
             [f2fs-dev,v9,07/11] f2fs: describe xattr block layout dynamically
             [f2fs-dev,v9,08/11] f2fs: parameterize sector conversion macros
             [f2fs-dev,v9,09/11] f2fs: parameterize byte and block conversion macros
             [f2fs-dev,v9,10/11] f2fs: describe node tree geometry dynamically
             [f2fs-dev,v9,11/11] f2fs: parameterize block size and mask macros

Patch: [f2fs-dev,v4] f2fs: drop pending discard commands before reserving device alias
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1157259/
  Lore link: https://lore.kernel.org/r/20260903161031.1280195-1-daeho43@gmail.com


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
