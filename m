Return-Path: <SRS0=fJ/4=PU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D018AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Nov 2021 20:05:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9027F61051;
	Mon,  1 Nov 2021 20:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9027F61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mhdYB-00079t-Ts; Mon, 01 Nov 2021 20:04:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1mhdYA-00079n-2Z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Nov 2021 20:04:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AAP9KDTyiGMA3cSkA+5w5BfHZa7oArZc8LMLNTtR9UQ=; b=ltc2NHcaSGkdGhibZsUhPwnCrZ
 eSauo84rED8m+RJF20eCgRwSZuUV75r3fr0FocoLqPgB0MGB5T/N6Fdnj1V4hvreHJ2sww+ne89CN
 3CnWit/fI6COUIiF/7zYBohL7QlPuviIOm/kDKwuycUfL+58vd729qVsT+MGcvrhF4V8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AAP9KDTyiGMA3cSkA+5w5BfHZa7oArZc8LMLNTtR9UQ=; b=h/6E1HDgFSuymeo8XCdmmnEKdJ
 7pd+WxkOVTsU5HPETxtfWGgI6FiB+/AZp+hS/zbjHm5YjmqCCP+a5bBNUwhuinNTZZtjq1peTiC4t
 cBjbpaF9ebmuAAyGVId+H/HEVjrv3hccphG7jfgnfV8jS0wKRMnXaOtjEdTuuBt7IkGM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mhdY9-0007ta-Gp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Nov 2021 20:04:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 2364660E52;
 Mon,  1 Nov 2021 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635797087;
 bh=DsJjDkX8TRbN+hOtR000e0+OFA+4mRj8nd5JbJ7Ja9s=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=TBfrZXUf8OEFlAQrR19+evjH39yVDJt/f6pVOf0Q6c//5CWp6W8j0/dJw0OJnpQ6u
 lPc6kzLPoqXCx3fd93HC1pr+7rIJhvbiWmeuzGz3Z8+PGtR+3tMaOvZjKJKA3Ojrij
 GRgoUAFJhD/de3UKM5Ej0SK74si3GT4n648Akl9EAQ2o7PO/suyHGnAjng3N6d72K6
 tdLJvTff70l1NHCM0C+i8Xdh8EswObMcDLJhkKdp6Q1tpp0r8TpMYGyv608Ql+W6Bz
 FYsD/zDY0IcBFb3kQ+qajhIm34AdI6zj1UCEAlIN6Vzx34mZs9Vk6/IfiU/N1kkPJg
 z4VI58+LfytnQ==
From: pr-tracker-bot@kernel.org
In-Reply-To: <YX8jdp73zUDwlB5E@sol.localdomain>
References: <YX8jdp73zUDwlB5E@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX8jdp73zUDwlB5E@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: b7e072f9b77f4c516df96e0c22ec09f8b2e76ba1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd3e8ea847eea97095aa01de3d12674d35fd0199
Message-Id: <163579708701.1875.9945029262289027407.pr-tracker-bot@kernel.org>
Date: Mon, 01 Nov 2021 20:04:47 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1mhdY9-0007ta-Gp
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 5.16
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

The pull request you sent on Sun, 31 Oct 2021 16:15:02 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd3e8ea847eea97095aa01de3d12674d35fd0199

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
