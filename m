Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBE8C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3SDhFjzhWtk4lKztrkUkxZuZYBpZfhaah9yXtkQG9XU=; b=ZfjIEnUS5h7ku+2VT5KKDFdJ1k
	1+JQnxz+nX0pQ7cLb8viDxXMEFNha1jphM+2GwMM+lGNNNDvLLEBxOVlpLp82i5vR9VlxuLYv6pev
	Tn6uihSbGYlotQ0vuRloj7edw0tcohI+6ZbE5cBdXvK1TWuSVYOxPRDFLd7CN5aTgBo4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2GyW-0003mi-MP;
	Thu, 03 Sep 2026 23:36:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2GyV-0003mb-Mg
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v8aIrl8FVNE6aDkNh/Sn9rVod9l059Np9k7ejf2G7Kg=; b=L2lIpQjZQHkfoc1v+XowpRgc2z
 DxYmfrxnmOmH/RQCJcFWRl3ownS5iGc5V9iC6uxOXsihUfLa6+j6FBXja3/R3T6D6n+An1Quuj+Ql
 z8wht3GoxN6nuUZvQVGudim49Wl2l/CeWk+j2E2jYr2M2SdHMl5I8xmPhxfSygYZD0qI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v8aIrl8FVNE6aDkNh/Sn9rVod9l059Np9k7ejf2G7Kg=; b=QZvNDrVPfgKmGHQahygsMRBAEY
 G/jwRa0u8XRGlnYHGPWO/pAZFi2oOHmD+9gHyrAYRDWTE5LM0eIh6CteilEHNe5/BELVUFMjAI6wr
 eqOipaKpB0Ksa0Bk+DEGx2GieR8MXXbGQKxUrdj7u9cKMoqX7MDjALwKwmGwoPb6yThk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2GyV-00025Y-Uu for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:36:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C48C60234;
 Thu,  3 Sep 2026 23:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79781F000E9;
 Thu,  3 Sep 2026 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788478561;
 bh=v8aIrl8FVNE6aDkNh/Sn9rVod9l059Np9k7ejf2G7Kg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=KJBsWWAgiY7bZAdczjlBKPK+A+g1bSw2Ltmet+yOfXViPWPT9nX85sPgD4susLSRB
 SkF48OCrzoj+9cls+B1it4Mqr41KoGYgUuh4it0Ajm8fHW5HsEeWX7lwU/lQI31JMs
 1+1AcLS0Jv1xgCN2wYbVnxZ5Z51nD9lCXt+YGJK9dLcrWXIfd05OhNjNlhpCurpKPH
 JQ2i7XQ1uQd3psgHkQpCR6oW3CpWLddkm7jCG/cFpiZc79fZkynsA4Va3xTFrzVmSS
 Sx9QmP2hQfxDeqTbqciEaufKQbVKcxgxSwQLS0VlSwUdEwL78ely9l6StNubupGunq
 I+n9a1mBe7YGA==
Message-ID: <4875d343-78ed-4a44-a479-f96b3847e8bd@kernel.org>
Date: Fri, 4 Sep 2026 07:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, fstests@vger.kernel.org
References: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
Content-Language: en-US
In-Reply-To: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
X-Headers-End: 1x2GyV-00025Y-Uu
Subject: Re: [f2fs-dev] [PATCH] f2fs/024: add missing execute permission
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
Cc: Zorro Lang <zlang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/31/26 18:41, Prabhakar Pujeri via Linux-f2fs-devel wrote:
> The test script was committed with mode 100644 while all other test
> scripts are 100755, so check fails to execute it directly with
> "Permission denied".  Fix the file mode.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
