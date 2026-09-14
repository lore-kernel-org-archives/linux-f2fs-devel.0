Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F720C88E75
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RcHebHMtpS71192e9nYstjpjNZsBCnKMfpC2YKOeU0=; b=Q354I76Lcksxi4N20Z/EP0XVkd
	ZfFOvs1xyGyZlLIUC4FF/q6+RReAn/jLHeasC1FBUx41P++v/MeM0NQaIy9tblDToWGaQ6V/kXGgx
	zEIJoYMxB5omMt0+15/9er8GcIYmCYPNebyc2/lP0BvdVXPPwpOHaYXVYNvUDX27zJPQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eb-0008QW-Td;
	Mon, 14 Sep 2026 15:31:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68ea-0008QI-3l
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nR/vh4GvI0WOU5I3SDjzgrYVoTA8r4/N125W3zwVcoM=; b=aHM1pQXkVxkrZ+vibOza/mm9sk
 3IVdAsvt082BFwo8DtDJs50Pt4BNUgZMkLRVlNneuuuovxkMdVfjLshCizBYUR2IZIted3ARgpohB
 luc2rcbopowvV4c2edDkCfMEC91TdhxH5iVn45QWkd3S0jVrCx05Hd9ED42QeZyntpZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nR/vh4GvI0WOU5I3SDjzgrYVoTA8r4/N125W3zwVcoM=; b=L45WQrcf/tIvsnkv2myFpUVoPj
 hWLOZYkjs6G2ruQMo4IXKVeJMQa88FPpYdZ7fwtZm51LzvznohgGvxO7mimY7zU6thQmfz7MB+wrw
 Ne1Z7pqweZQLkfvcLzmVAbncgQbG9d6Lub1QyB1foppw2Lt52XE8hSsYr/1aQqNBuGH4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eW-0003TS-Uu for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 953F9408EA;
 Mon, 14 Sep 2026 15:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F361F0089A;
 Mon, 14 Sep 2026 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399883;
 bh=nR/vh4GvI0WOU5I3SDjzgrYVoTA8r4/N125W3zwVcoM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=RbCEKtn4AO+w1y1Nm4+9OPjd3F5HeNMHAg3uez+4FdxFCGDSSpv7EiKf+nOYlAqRD
 WpbEgLLqAW4/l8pXzRAprjeTjPg5iYhCGnBEarYYppZgnkrHtBmnFS9mupbuYxw5uF
 9IaiI70goJcN/QHzRT88UUSpAI4Re7c2DETfrByKeR3s4TjTlq6nG8lVpXAeCBJkvv
 0JK4xXezKzgYlQ+Oc3bwKs3QN943NILxYGwTYwEDkh+jk8qAJukkZVAb2U57/OORtM
 maeohl2NdOmJIEX01jxCO7utzNVfC1W0jyXsjrJ+AH6xFXa9Zfjke3MaE5gkTOu/bL
 U9AI6BB36tibg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D092A3924A79; Mon, 14 Sep 2026 15:30:19 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939981839.647967.9641554131485178993.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:18 +0000
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
In-Reply-To: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
X-Headers-End: 1x68eW-0003TS-Uu
Subject: Re: [f2fs-dev] [PATCH v4 00/16] Remove PG_private by using
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
 ceph-devel@vger.kernel.org, ebiggers@kernel.org,
 xen-devel@lists.xenproject.org, gourry@gourry.net, acme@kernel.org,
 linux-fscrypt@vger.kernel.org, skhan@linuxfoundation.org, david@kernel.org,
 surenb@google.com, linux-kernel@vger.kernel.org, nico.pache@linux.dev,
 linux-perf-users@vger.kernel.org, oleksandr_tyshchenko@epam.com,
 mhiramat@kernel.org, jolsa@kernel.org, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, trondmy@kernel.org, mark.rutland@arm.com,
 linux-doc@vger.kernel.org, dave.hansen@linux.intel.com, song@kernel.org,
 hongbohbli@tencent.com, ying.huang@linux.alibaba.com, sstabellini@kernel.org,
 vbabka@kernel.org, senozhatsky@chromium.org, byungchul@sk.com,
 linux-trace-kernel@vger.kernel.org, jaegeuk@kernel.org, ljs@kernel.org,
 joshua.hahnjy@gmail.com, baohua@kernel.org, kasong@tencent.com, tytso@mit.edu,
 magiclinan@didiglobal.com, muchun.song@linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, minchan@kernel.org,
 lance.yang@linux.dev, tglx@kernel.org, anna@kernel.org, pratyush@kernel.org,
 amarkuze@redhat.com, alexander.shishkin@linux.intel.com,
 linux-mtd@lists.infradead.org, guochunhai@vivo.com, corbet@lwn.net,
 dev.jain@arm.com, willy@infradead.org, slava@dubeyko.com, xiang@kernel.org,
 weixugc@google.com, baoquan.he@linux.dev, james.clark@linaro.org,
 rostedt@goodmis.org, bp@alien8.de, baolin.wang@linux.alibaba.com,
 shakeel.butt@linux.dev, tz2294@columbia.edu, idryomov@gmail.com,
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 13 Sep 2026 22:23:58 -0400 you wrote:
> Hi all,
> 
> This patchset removes PG_private to make space for upcoming PG_folio for
> identifying pages from a folio (more details in Note below). Instead of
> checking PG_private, all code is changed to check page/folio->private !=
> NULL instead.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,06/16] f2fs: stop using PG_private
    https://git.kernel.org/jaegeuk/f2fs/c/60105162524e
  - [f2fs-dev,v4,07/16] f2fs: convert the ->private flag helpers to folio-only
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
