Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF88C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I4WSGmFN/AvQx9KKsDZdU8HiSf54FIM3wkKFL7xiwpY=; b=XISsTxkt7L51ww44K79ZkdWYhT
	S9edt1rYKOTXNSHcng0MpCYMKVP3VmsLjRYR1UI5HsqsP4V2KUDJt5rE7aAbJerlMlAydT6o8q5Sy
	JkJkDntTcbiF7apvAgUxKT6s91A1WNn/ebGZHmHTzrvvp7CvpiTeI1buaev2ffeGrE4o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x420j-0003Dd-Ik;
	Tue, 08 Sep 2026 20:01:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x420f-0003DM-E5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 20:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mn2z802etyyKFuQdlZgVT3N2OhEpwVAgB4Jn5ZVA/UI=; b=aMQc/zotjyffz3z/sQI0Cz6IfR
 6sCqpa6RIImqRt6S4sfYwTcIL3ihyyojfo3/MQByKaBGSCaa9cmLFODtn/8vC5ndpqX6X1gcaBwGr
 4x1GpVotw3KJ7j1+js/IWobZB3LWJeNny45hyDWXzHMQ11RJwKD+UR5EGsAFo+96ZfOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mn2z802etyyKFuQdlZgVT3N2OhEpwVAgB4Jn5ZVA/UI=; b=cf+H9MfHBKZ83jOCoq89IjCB5N
 KgMzWRELqqpiWU9bwjSz8x4T9x+BJpeC6iAeWog+WyPigAKWiY36I4t97l+Wji8TF5KaF2cjuqZUN
 jHM+JJLaJ405BS07sfV+ZgfSQLf3nJp4uVPFFHHBkV6RCZ73DrhELhQUCqPc+zKC2ELI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x420J-0001ET-Hs for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 20:01:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE890601DE;
 Tue,  8 Sep 2026 20:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DB31F00A3D;
 Tue,  8 Sep 2026 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788897669;
 bh=Mn2z802etyyKFuQdlZgVT3N2OhEpwVAgB4Jn5ZVA/UI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=lRPEra+rmdTi5LkKVLuU4FRgbKIynMb4corkf4RBuMGsJGIzXCzwAqmGhGizciJDe
 cQ6bxi/wBslbGqyHkmsGEd1WV0NMIGvvS7W1lONEjmOd+N47Bn9Al97RFQLau+oqI/
 2Z1UDXSArHsZlhbxhxSdz5a1QQ4un9tB3yHQCC1BW1P62iAQR0Vo8IFJQbO/G+ZsSu
 0n9Vc/thbN26lelWGC2ZumSd7wDMkOfM71C/DMQEIxGD8tflMEr9oSRYKT6dEolYS3
 dKCGO67i2YqqakOz+sn0jU9hNC31UdADi7YmqTcPDCfp2fj99/0tzylCvv6i2Y8GHh
 hN7D+Wqu2Bjhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56927380820D; Tue,  8 Sep 2026 20:00:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178889760788.3720652.6767085616150933422.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 20:00:07 +0000
References: <20260903161031.1280195-1-daeho43@gmail.com>
In-Reply-To: <20260903161031.1280195-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1x420J-0001ET-Hs
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: drop pending discard commands
 before reserving device alias
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  3 Sep 2026 09:10:31 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
> f2fs_reserve_device_alias() bulk-marks all blocks in the target device
> range as valid in SIT.
> 
> However, if the device was previously in the released state, stale
> pending discard commands covering that range may still exist in dcc->root.
> When f2fs_issue_discard_thread later processes those commands,
> __check_sit_bitmap() detects valid blocks in the discard range and
> triggers a kernel BUG().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: drop pending discard commands before reserving device alias
    https://git.kernel.org/jaegeuk/f2fs/c/5200186c8cf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
