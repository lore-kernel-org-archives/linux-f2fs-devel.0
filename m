Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFDDC4452D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3KqqtJYvW6BNF37l2kRIDaeTKQNQnWxQckAJzb0t8GM=; b=C4BE69IynXUTBMdEVAt2FfSvxo
	WmMxwp9o+39DV8FkP0QO4tp/wPc96FF3J4RiKbt/l5aIm5N8kZGvYaBXOkSh5U0lqAlHOfGS571R6
	qwJC00bmFpmh9phJ4dGB7Y6GOWlwCK510aFi2OZ6xGyhlx9QXyFnjcg3Sqmh2YCFpCqw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmJ4s-00077y-DQ;
	Tue, 21 Jul 2026 22:36:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wmJ4e-00077k-Eu
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9xR7aJnjzbB0cYi+HaNX5c/+Q8nLrvfNR2N4MpRwZ98=; b=jJtoqgU+5XSkAR03PALTrVy6b+
 sJMiZu8wRPcqKFJv/ButgtodnOY4e/VGymNTmqI/X1Ztp+6Y08TBuekuQTssWG6oXtYq8D6Q/Gbvp
 /i/3IZkUBS9aHqIZkMC2rP22dc1ec6AccMEDE+TYcqsU6rtQLaevjRtO8idxYHHmVFZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9xR7aJnjzbB0cYi+HaNX5c/+Q8nLrvfNR2N4MpRwZ98=; b=JklJzFHC32layiW/pwJiuE3lCs
 CcImIo3l/zYGWqhu1MlbCF0LP1yzI085a7iRK3wXI27/gBDaNewA/sm8ZHznhhTpmvLqo/+LTMx5E
 TO9NF7oXMNkDFH9gsRS5WFMmEQj/kURX3iScipI/F2B5MXSc/MfbCDWc/7s3JIeoGnqY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmJ4e-0003is-1F for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:36:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D70343B71;
 Tue, 21 Jul 2026 22:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87681F00A3A;
 Tue, 21 Jul 2026 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784673377;
 bh=9xR7aJnjzbB0cYi+HaNX5c/+Q8nLrvfNR2N4MpRwZ98=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=FeUEUmhbdNSPNuGvEeQbCU3d9I3vpKGzmnK+ikTxAY4qi/sTc+8fe97jlDEgL26fD
 Msl1Jsk0SufN02KXKiDCFkzYbxAy1TMhwangB6K7CKYi6oFnumjIrclNOix7AZREmW
 qxKT48odeELUJ6vlc7Z7Hh2TQWQVYT5PSyBHzghrYpE3qvjeQtt8pkbxkl916sFs6X
 vpcLMTLhnKfsY0DMdVfm8DiBIZqHvmnrdDBoGO+KdD6P0F5NG/mAZhD185LYJIDvxe
 uoLaPb741UAkxpblp3pqQgza9D0SJE6wdXB99GVsXeJ73hFtHbHWtWQ++Re+kmPvbj
 xt/YxciBvWE/w==
Message-ID: <328de723-6f9c-4f09-a68a-da24d49300d5@kernel.org>
Date: Wed, 22 Jul 2026 06:36:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Darrick J. Wong" <djwong@kernel.org>, Anand Jain <asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
 <2ac5fb22fd6b51973d11082a1ee8fe354926c63c.1781694879.git.asj@kernel.org>
 <20260701173314.GH6517@frogsfrogsfrogs>
Content-Language: en-US
In-Reply-To: <20260701173314.GH6517@frogsfrogsfrogs>
X-Headers-End: 1wmJ4e-0003is-1F
Subject: Re: [f2fs-dev] [PATCH v7 06/11] fstests: verify f_fsid for cloned
 filesystems
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: hch@infradead.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



> This is where I continue getting stuck on this patchset -- fsid is so
> poorly defined that I don't think the rest of these fsid tests make
> sense at all.  Nobody mandates that fsid is persistent or stable across
> remounts.  Nobody even mandates that two cloned filesystems don't have
> the same fsid value.
> 
> The statfs manpage says:
> 
> "Nobody knows what f_fsid is supposed to contain (but see below)"
> 
> and then:
> 
> "The general idea is that f_fsid contains some random stuff such that
> the pair (f_fsid,ino) uniquely determines a file."

Which is exactly why we need fstests guardrails.
Keeps filesystem's implementation consistent across kernel versions.
Embarrassingly, I introduced a bug around this that is now fixed.
The commit IDs are in the test cases.
Thus motivation for this fstests patch.

> Based on that very weak statement, at most it might make sense to check
> that two separate and simultaneously mounted filesystems don't end up
> with the same fsid 

Yes, for xfs, btrfs and f2fs. However for ext4 cloned filesystems can
share the same fsid and ino because the images are identical.
It is then up to the usecase to change the UUID for either filesystem if
it gets modified.
Commit ("fstests: add _require_unique_f_fsid() helper") captures this,
and the link in that commit includes the discussion.

> just in case there *are* programs foolish enough to
> use (fsid,ino) as a uniqueness check.

On the other hand, if a program needs a unique ID, do we currently have
any way to get one?

Thanks, Anand




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
