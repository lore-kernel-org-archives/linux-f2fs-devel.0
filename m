Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83641C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Dec 2022 19:24:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p5AtM-0001SY-Lt;
	Tue, 13 Dec 2022 19:24:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1p5AtL-0001SS-5r
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 19:24:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iAdOIVd35tyF7XMOZv+Dj4Wc2c1Lcml9xNfYDIVcZjk=; b=aoDIpVG0kZ3rSfOZnnBRvtQ+qS
 9fh81lKHgcjuiDP8lMhBL2zAwiQiRSdF2x/S+7NTvbaGYu8BXtr6EGhq60rLz5mEJm/zjcbAwevLX
 huXBs0a6OaiLP/U+ZT/HjEdrQxsRxqpcK4oINRQf8yXAi0PFeEN31jkG2aLPE0Gpvyew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iAdOIVd35tyF7XMOZv+Dj4Wc2c1Lcml9xNfYDIVcZjk=; b=X
 WeNA3c/C7mxDMFCbtESmrjPycAxrHZeiIn2WSfXL0z18CeW8frYQ9DFLLa9yDhfvjJ/9pl+1kRJHF
 vHjQE7iO8gURwR608cDcgn5/mnyWD5/oK/k6/J8MHtafqbcdqcB+2eU8GoCz10ov8Y1P5UfvTPG1A
 8MNxaJb2ZhVPF0gY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p5AtK-00089Y-GP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 19:24:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 37E1EB810AA;
 Tue, 13 Dec 2022 19:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B92C433EF;
 Tue, 13 Dec 2022 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670959470;
 bh=JoyGbc+CLt4wv3FeRw2pIl17kK3ZvDF0ImnJxpQ5c/Y=;
 h=Date:From:To:Cc:Subject:From;
 b=BNjAa4sn7uBdZzM2UUtrfuKyvZ2TkkcjQx+mps27l+EIBJRt/A+XXPDL6U2fWkHeQ
 ehwrbL2J5i9mH2N/Q0K9k8HJ3iKhCow1syUMQqidpUw70i4P22F+Xe9pqI6H6rTzSH
 sVGoZ2IAjmAOFBJdlO3uvhITk21DnSyFXRxQTQ+xDpn2K3Lo6Fm8fLOtBlrj3TfQn7
 Z7vb8hFzixNi89ghpVTypl/OBNZ3O3q/KElOb2cmkJgOl0JEN351XZzM8WpbGlAQrz
 ADNVwXg6qJc4NFfHh5F9zpuMRCJui49m56yS2ynnKaEM9OQ5Dckho9+HyEiRhSLCM0
 OX5eYOYsCD/Ag==
Date: Tue, 13 Dec 2022 11:24:28 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <Y5jRbLEJh3S46Jer@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1p5AtK-00089Y-GP
Subject: [f2fs-dev] Separate mailing list (and git and patchwork) for
 fsverity?
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
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Currently, fsverity development is reusing the same mailing list, git repo
(though a different branch), and patchwork project as fscrypt --- mainly just
because I was a little lazy and didn't bother to ask for new ones:

FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT
[...]
L:      linux-fscrypt@vger.kernel.org
Q:      https://patchwork.kernel.org/project/linux-fscrypt/list/
T:      git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
[...]

FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
[...]
L:      linux-fscrypt@vger.kernel.org
Q:      https://patchwork.kernel.org/project/linux-fscrypt/list/
T:      git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
[...]

I think this is causing some confusion.  It also makes it so that people can't
subscribe to the list for just one or the other.

What would people say about having a separate mailing list, git repo, and
patchwork project for fsverity?  So the fsverity entry would look like:

FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
[...]
L:      linux-fsverity@vger.kernel.org
Q:      https://patchwork.kernel.org/project/linux-fsverity/list/
T:      git git://git.kernel.org/pub/scm/fs/fsverity/fsverity.git
[...]

For the branches in the git repo, I'm thinking of using 'for-next' and
'for-current'.  (I'd also update the fscrypt ones to match; currently they are
'master' and 'for-stable'.)

If people are okay with these changes, I'll send off the needed requests to
helpdesk and linux-next to make these changes, and send Linus a pull request to
update MAINTAINERS.  (And update fsverity-utils to point to the new list.)

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
