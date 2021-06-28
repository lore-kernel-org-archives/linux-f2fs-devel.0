Return-Path: <SRS0=QpjO=LW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8800FC11F66
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jun 2021 23:36:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F41661D1E;
	Mon, 28 Jun 2021 23:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F41661D1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ly0o6-0003Cs-At; Mon, 28 Jun 2021 23:36:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1ly0o5-0003Cl-N2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 23:36:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nrJ0UrtMYXTO5PtV40Mr12K4SlB8J8e/kFiadCjr8qk=; b=kwxjh+i3itewZh/VvQqZZjE4Cj
 RQ/KUZNmMhYZNDmVwtQ7crkRNXdeG8UmUpRp2RLs0gR/2CucaeKQwLrCHi0dsW/FEOe0FQvisej9z
 ciun8b1GB88+JoCbvvwMg3QCbpqA/AdxhkwmYS4pqQvipTegyehbbViM9hUkREBZlnEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nrJ0UrtMYXTO5PtV40Mr12K4SlB8J8e/kFiadCjr8qk=; b=KvZQqoAoYy7HsZ/Ndxk52XO4xq
 rZh5UrIE8i9R/TcwAfbw20nESTZSChCQotnxgh1lk0QHm1d7P3NMviNdr3vadM/pi7MvFH5x7fEW0
 7mG0Ji5EU0i6Erwp03LLdkc69LWTR16H12sMiZSWGVi0OT0xA96aSrORtdFTqojGBLNQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1ly0ny-0003Q2-9U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 23:36:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id F262861CF4;
 Mon, 28 Jun 2021 23:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624923392;
 bh=olgmlCCEXgbIRO4D3Jq6NI3qVCMsbVCY+zrABexZDW0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=DSx6uHbVVu0v8Mm36qD/eblip+oQCi5TStiOlwzscjITCTLxQBsXvqFaDHoc7xp63
 gdoD2ZTxjZ+Tp1M0Qe9PV54QiG5RwI06q+Ss2lbTbqml3G3nsiz4eLGsZsr/YTiZ6+
 /b3ktFaVxv3z8FB47+4lG628xYjyO8KRNUWPvg+5OkEDopeDpQ7OZSIRQnB80mwePh
 wTsOa97jcrAN9CoJFOk0YymeAmqUv2ehZa0Z/ReFK2Di8F8hU5/ew5HZerRkBnJc/D
 vlcDIBXjmOzv7NfBBYldnBf6fofDIgPNSSla/+TUnFGvp/MS+QQFNpUX0KwZwCk5Fb
 2FZss+xtrJTjg==
From: pr-tracker-bot@kernel.org
In-Reply-To: <YNn/TL5lW44yAx3o@sol.localdomain>
References: <YNn/TL5lW44yAx3o@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNn/TL5lW44yAx3o@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 2fc2b430f559fdf32d5d1dd5ceaa40e12fb77bdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a58e203530ebdf6e5413bebc7f976d756188a4b5
Message-Id: <162492339195.13806.1637347361707615822.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jun 2021 23:36:31 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1ly0ny-0003Q2-9U
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 5.14
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Mon, 28 Jun 2021 09:56:44 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a58e203530ebdf6e5413bebc7f976d756188a4b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
