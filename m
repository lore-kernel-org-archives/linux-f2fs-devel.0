Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8583AC88E78
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ceOssuT8KmOdvup92tYNnk338qqmM5xIv9k1NlDCbpA=; b=j6Kveo56tpBH16YQvx88H8/gF7
	YwMvCq96ML0NGM722fzB+yGq1Y8YRBjWsPKNgCkKgPR3858Ta24LmyjlboYNh/B40EQnaOW0oxcNB
	AhGuZxzACOiT0eQAnJ3txXjxTA97G2/ng8OnBin0c1qcXG0A/AOLSwGBOanrd4u9A+to=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eY-0004aL-PY;
	Mon, 14 Sep 2026 15:31:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eW-0004aF-Bk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6YNBDNqtv3G7fIIrCWxRo+R7rFxECIiWXZYEw0TsCm8=; b=AuMYUoFMlbZllxszWdfVwEtx9N
 HIQWblCIPpDTKXrYtZhmwiTZ8iOb3GhkSnnmRV1JmDy0Re4MlJ5glhq3nKQLDf0ndxyvVvZnn/0tV
 LsxhiP5Yk5kmeFJHfUGK4GrUlglLwNP2GCvEgQyRaQjPhZCfxahGLS3cJnFBASQwV+Jg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6YNBDNqtv3G7fIIrCWxRo+R7rFxECIiWXZYEw0TsCm8=; b=DYVI6tVoVbdd9cT72NQeQzrGWM
 hoiaGOzSCdH+pPueZZhS1aYZoXxMKPw9qYD2W+ZiF5pUM2yVpV8pwQyWbvWudh76lZkOCBBKFXJvP
 GK4b4V41ncJ6wufa0w12E0H1PoV062nsraHszgGCQ9gYHdCL49BFk3HbeB+nreu5LUQE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eV-0000Hy-Dw for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2734740124;
 Mon, 14 Sep 2026 15:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D7F1F00893;
 Mon, 14 Sep 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399882;
 bh=6YNBDNqtv3G7fIIrCWxRo+R7rFxECIiWXZYEw0TsCm8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=oafm7V4RKsPy/Q1nCVBWDqYf7CzIKQWwzaAUfYXO4K5blgVLNKT30EOhNjyiJ68b4
 EmE0pg7kCS+rsBO2hQhqAcC1jDNgaAjoHfS35HWN3j5jboLSqfna8lVYkkpRTOVBLm
 z7XrVJIhN7zqa0ZqIGC7moq0IJyRMgoMb82ImK4Ze2REEcVBWDrF/nBND+suW7cTj+
 wRFmHT2zlonTyo+1brM1i34j0QTrbmA5FknqN7kXJ9bimmAF15wqhMttnovE1K17hY
 mCHO/L8QQoVL9DoTMRTdTxGNm4LGmdWMH05qUrovm9ES8pb0mcHRy3YO183W8YwGVi
 tCv3P8ki+lNgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56B213924A79; Mon, 14 Sep 2026 15:30:18 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939981687.647967.15609695091265022344.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:16 +0000
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
In-Reply-To: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
X-Headers-End: 1x68eV-0000Hy-Dw
Subject: Re: [f2fs-dev] [PATCH v3 00/14] Remove PG_private by using
 page/folio->private checks instead
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
Cc: qi.zheng@linux.dev, matthew.brost@intel.com, apopple@nvidia.com,
 ebiggers@kernel.org, xen-devel@lists.xenproject.org, gourry@gourry.net,
 acme@kernel.org, linux-fscrypt@vger.kernel.org, skhan@linuxfoundation.org,
 david@kernel.org, surenb@google.com, linux-kernel@vger.kernel.org,
 nico.pache@linux.dev, linux-perf-users@vger.kernel.org,
 oleksandr_tyshchenko@epam.com, mhiramat@kernel.org, jolsa@kernel.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, trondmy@kernel.org,
 mark.rutland@arm.com, linux-doc@vger.kernel.org, dave.hansen@linux.intel.com,
 song@kernel.org, hongbohbli@tencent.com, ying.huang@linux.alibaba.com,
 sstabellini@kernel.org, vbabka@kernel.org, senozhatsky@chromium.org,
 byungchul@sk.com, linux-trace-kernel@vger.kernel.org, jaegeuk@kernel.org,
 ljs@kernel.org, joshua.hahnjy@gmail.com, baohua@kernel.org, kasong@tencent.com,
 tytso@mit.edu, magiclinan@didiglobal.com, muchun.song@linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, minchan@kernel.org,
 lance.yang@linux.dev, tglx@kernel.org, anna@kernel.org, pratyush@kernel.org,
 amarkuze@redhat.com, alexander.shishkin@linux.intel.com,
 linux-mtd@lists.infradead.org, guochunhai@vivo.com, corbet@lwn.net,
 dev.jain@arm.com, willy@infradead.org, slava@dubeyko.com, xiang@kernel.org,
 weixugc@google.com, baoquan.he@linux.dev, james.clark@linaro.org,
 rostedt@goodmis.org, bp@alien8.de, baolin.wang@linux.alibaba.com,
 shakeel.butt@linux.dev, ceph-devel@vger.kernel.org, idryomov@gmail.com,
 osalvador@suse.de, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
 linux-erofs@lists.ozlabs.org, rppt@kernel.org, irogers@google.com,
 mhocko@suse.com, jack@suse.cz, peterz@infradead.org, ruirui.yang@linux.dev,
 yuanchu@google.com, liam@infradead.org, hpa@zytor.com, zbestahu@gmail.com,
 rakie.kim@sk.com, richard@nod.at, x86@kernel.org, mingo@redhat.com,
 yukuai@fygo.io, axelrasmussen@google.com, ryan.roberts@arm.com,
 pasha.tatashin@soleen.com, usama.arif@linux.dev, xiao@kernel.org,
 linux-raid@vger.kernel.org, jefflexu@linux.alibaba.com, namhyung@kernel.org,
 jgross@suse.com, kexec@lists.infradead.org, adrian.hunter@intel.com,
 hannes@cmpxchg.org, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 07 Sep 2026 22:56:07 -0400 you wrote:
> Hi all,
> 
> This patchset removes PG_private to make space for upcoming PG_folio
> (reserved as __PG_folio) for identifying pages from a folio (more details
> in Note below). Instead of checking PG_private, all code is changed to
> check page/folio->private != NULL instead.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,06/14] f2fs: stop using PG_private
    https://git.kernel.org/jaegeuk/f2fs/c/60105162524e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
