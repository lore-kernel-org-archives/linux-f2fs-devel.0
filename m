Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6702CA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 02:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xCQWbtlx2IALB3+KGF6VKK97n/rVfKoQ58FZVgQ05fQ=; b=VXbvTOSX/qN+AhrXvJInTKnMH/
	lBHwDCyunY1vD5gGkk7nb8rlmVh3V+Y/RzhjRiQIat7AA1l/8plhpt3QLwD5grnnO9eFWWJQ4EpGR
	tNxpVf+l96M1U7Im/oAeB/8ougyh0b4CfYU7Ntr94gYEurZsaYrEcWBv8r1kLIalsClI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGRro-0005JA-En;
	Tue, 13 Oct 2026 02:03:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGRrm-0005Iv-JK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 02:03:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wXnVIQ6CjXIwdz/GegtJq7WvjeBvK5ddziZzXuB3S7U=; b=HJxrRjeABpFFCbROO0eqUb4LIj
 YRGedf3FXnntYRn/NeY/IRg6nn00izCTsanYc6Z28C7ftXdWe2L2DMn7PUE1BwQ4xXYluXefKz3gT
 BN3iCMf1abjqo0kqDQ2siV3PICURx0cVCUg0d26lvZn0juMWYb8YdF9l2+0u714UDQzc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wXnVIQ6CjXIwdz/GegtJq7WvjeBvK5ddziZzXuB3S7U=; b=Bgja8uXzqUariDcFqgQmOfIL+p
 4scWdrvvNnjTr+C7BDxmyNtLyvclUVmdAUeQIKp3uGhs3vqxRilAheNE/uzbY3VJoYDa/GY9MutIA
 cFhxbL0n+EB8PHK9+VyGiLCsb55QuFeZ1PRtBTeqnUDl4HEgMeKwhLB0z8KhbyRFmaSs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGRrk-0006hX-Po for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 02:03:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 657CA40253;
 Tue, 13 Oct 2026 02:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90231F00893;
 Tue, 13 Oct 2026 02:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791857019;
 bh=wXnVIQ6CjXIwdz/GegtJq7WvjeBvK5ddziZzXuB3S7U=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=PPypO1sS+RubS0l15hO3Ei+aNAFqOGx9zgH8VIfU+1ssqJMjtOhX7bsR9GoDOA2hr
 VN0MoCxMgB7whgg6BEY5y8byYZqm7JM5tib19HMlw4HspJYx9mI/CPXOMJY0G0DK07
 DRIqReNorouUbllgmrnwB4ZB4niz4pOnGY70g8tZEJiScNHe+8GSePVCsoUrqquX42
 zisBkRQ1fCW1X5DPCkGwFD9iQTuprq6NAfgoxEJw+DE3/n4iThli6A8aRR42KsSHO5
 PZbBZZNE3DNt5tSLFydro/fcFjn3bu1oquoc7jsKyP+MoBjhUjtSHd8nk4Eei82IQ/
 8rNlR3A/i2TPw==
Message-ID: <e653fa44-162a-47dc-b02e-719cc976b133@kernel.org>
Date: Tue, 13 Oct 2026 10:03:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261001180758.2099491-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261001180758.2099491-1-daeho43@gmail.com>
X-Headers-End: 1xGRrk-0006hX-Po
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: enable fix_on when
 CP_RESIZEFS_FLAG is set in auto-fix mode
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/2/26 02:07, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Commit 9a31cefa2966 ("fsck.f2fs: allow fsck to fix issues with online
> resize due to SPO") added logic in sanity_check_ckpt() to recalculate
> and fix user_block_count when CP_RESIZEFS_FLAG is set after a sudden
> power-off during online resize.
> 
> However, sanity_check_ckpt() calls f2fs_should_proceed() and checks
> c.fix_on before repairing user_block_count, while f2fs_should_proceed()
> did not check CP_RESIZEFS_FLAG when setting c.fix_on in auto_fix (-a) or
> preen (-p) mode. As a result, running 'fsck.f2fs -a' after an SPO during
> online shrink leaves c.fix_on unset and fails to repair the checkpoint.
> 
> Check CP_RESIZEFS_FLAG in f2fs_should_proceed() so that auto-fix and
> preen modes properly enable c.fix_on and recover the filesystem.
> 
> Fixes: 9a31cefa2966 ("fsck.f2fs: allow fsck to fix issues with online resize due to SPO")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
