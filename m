Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCB7C79F81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5IMFZ7mN/SsIt/GMGVvVP+8OkD5k/AUlb3ef1rz6IQ=; b=TvNpo8Ug+MLuCiJuUcS9aahnE8
	Vs+Ud3NVFYFiD85fAZcqiVedEAn8iJxtX1wNSgbQhXLGCWtu6RCNtDUr12ZWvFXHRLWURNojfKcVL
	MGBBUZOunz+o9B1AMwmu/H51c3rYgq7oDztxlY7WJWX/gyTt4WITSjtwIfsaO9cjzxdc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2A1y-0005Ct-TZ;
	Thu, 03 Sep 2026 16:11:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x2A1x-0005Ck-Sn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wQC/B3FS4e5cPaDkFUi05H5/4Cpx4sxh25n+vGHWmYc=; b=KtebTsTKaEQ7uEjk8EBVaA1epI
 FT4bOnxMrG0Xy2l6mcg1WFy47qWbewA7JcBeieqUyJRGolxMKn+KY2eshZ24wEzdezdNUEnVm0aWY
 d2Vn+MQMQmanXGwPpAKPRJrLxdEYgI2n79g6DMdqewQ+xW3vDdBDSnQlMGrKKBPSTt1o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wQC/B3FS4e5cPaDkFUi05H5/4Cpx4sxh25n+vGHWmYc=; b=QL2gnoToe+d4+qBFFKIlewR2NZ
 n/UmTmK99JtVEIWiydO4u7gApw49mkYEnV4jEO9JUJfXEGJiah0W33iGtwnp64Vr+vf3Qd9Y6wQSW
 VkRNPy8LpRlh3nqmfFluIBWlPFf+8Kx965IzL7QIdSzzAyW1kj2f1siHRaYCEoch9eaw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2A1w-0004an-15 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:11:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60E6F60A5B;
 Thu,  3 Sep 2026 16:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119AE1F00A3E;
 Thu,  3 Sep 2026 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788451866;
 bh=wQC/B3FS4e5cPaDkFUi05H5/4Cpx4sxh25n+vGHWmYc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=cX5S97uavmnQ1oACZHN9HgQC0w4BW6l7gd3KhLLv7D3CEwvQqVkkISIabPe6cAz15
 lWkG+FcJx8T5bL8zvHYmPd7BTeb+q0xV22oPkTs+7zHVI76huUqtzlAazKHgiijpXC
 fPayLcChJfd8lQhKnDDxnDwCYBYoono4GRg6E8M/XmWnKu3w06nB/6JtY5EZEZ4JTc
 Ls6Rs/u56x5sozaE9TxltbKV3YH5hTFABAAIOg6efQ6qc4ZyXelz1bMHFgK7aaDnWZ
 9Y02WV5P78L1/Fs/n5/fmLT+8/kOHgOC2mjZC6o6yNFynXnGH6uYX4iYf9Gpt3FU4F
 Kd4tFkH7OtvQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 9386938119CB; Thu,  3 Sep 2026 16:10:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178845180715.3423963.14220073137991024856.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 16:10:07 +0000
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
In-Reply-To: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
X-Headers-End: 1x2A1w-0004an-15
Subject: Re: [f2fs-dev] [PATCH v2 00/14] Remove PG_private by using
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

On Mon, 31 Aug 2026 15:25:23 -0400 you wrote:
> Hi all,
> 
> This patchset removes PG_private to make space for upcoming PG_folio
> (reserved as __PG_folio) for identifying pages from a folio (more details
> in Note below). Instead of checking PG_private, all code is changed to
> check page/folio->private != NULL instead.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,06/14] f2fs: stop using PG_private
    https://git.kernel.org/jaegeuk/f2fs/c/5ad9409a9533

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
