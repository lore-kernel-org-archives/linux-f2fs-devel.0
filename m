Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4AED7237C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Jan 2026 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OWIwSAg8PoByidr/hgXPJLpeg0mBREAEFAYlGqF7JHI=; b=CDUWW9v5W+zxj0k8JLyEM6fv2r
	/Jk5HjrvW5AD+o8wCSv2sq6dtQ6kriP1A4Qt0EIOM33JtO+AfcPO6BuuQRUi8FoKt9zzAVuKHPDac
	pxqLcf3RoLS7dSQjJaq3dw5G/c9D5/qyvVZNoARybiLSZnT1IDN917yhEeO9gQpPYOTg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vk8EN-0002Wk-Jg;
	Sun, 25 Jan 2026 22:05:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vk8EM-0002Wc-6M
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Jan 2026 22:05:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LbFs3p3XeOmKicy0X4CMV8TWv3uiFDdC6PtvJFAElc8=; b=J7/RiWsEziGHIhC0kHF6Ssva0f
 Cbky/d6GjxatptCtwqtiFa4o31remNfFaz0NGiHqAzRgwD/ZE08PPx44heZhhKBjQITK0OoKL8VAp
 mjSUYn3LvHtiZWWz95TzgHlKNWLzUxdzU/GqoEQQ2e9BAvVPS8cMS/CAfm+RRXnUOq3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LbFs3p3XeOmKicy0X4CMV8TWv3uiFDdC6PtvJFAElc8=; b=myGPzx5zdiJ9oMMcJBWE0PZyvj
 FzZFlt+sg1E3spNDeLcm0pCl6aEnpWJcVfvpxTs5h7abOX4CCcqkKkWco2rhXJ3jHT8QT2HxWrsek
 wQIGvvBFepzBeIoObe5IC0nWr+jlX+svxZG1H6T//xGMJ6BIWIhlufjVigOp3wViTS/U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vk8EL-00035p-L2 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Jan 2026 22:05:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DF8236012A;
 Sun, 25 Jan 2026 22:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97769C4CEF1;
 Sun, 25 Jan 2026 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769378706;
 bh=kJ6JgpGimrqEkXHyyvMzGefViVzL30DBbsFX3mmThgY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=DyHfL3owAK89asDfhQXM+IKQMD6vTQqEPbBdlwvj3880nuKIlVyf0kJ1GWPbCGPat
 ucjDTwAD/CkI8yzM7fzV0IV1MPYMuEawgnD5iynCNY1ALkgKv9sFW+xgBFPy2nBWnB
 Vw+0zrgr5jSTJthmnkVQToa1I1dR/qL6o7Ch+y/wWUAc0vKP1TA6wWml6AXOjXI6Ud
 wRJJetxsZsBVnKN3ZkHGem1LlGmy9X9i3cYEDDqsf5mulhsYsRhiGDhq8pPLXkSRY9
 Q/jryTZwAIVg5WNUGz1emfgbxV2fX/c6/OJoOuOkdhXdxGxrwa/yVeRymmj5pXCgov
 /I04uTvCKfnnw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 8D84FF40072;
 Sun, 25 Jan 2026 17:05:04 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Sun, 25 Jan 2026 17:05:04 -0500
X-ME-Sender: <xms:kJN2accIXvnGH35KtDNF6o27-vsyP7fzrVQ3dK_GjAydqEa0PFcBrg>
 <xme:kJN2aZBa7y0fs14pjg7lavRyA7jBb1Qhce04atH46-2W2obEGeMJmlkomgp3SRqDp
 RxhMSUHJfOa5bplDrkrJDlMGsPyRyRCS3mbKX_4B0vg8QEm1E6G5Ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
 khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
 hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
 hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
 leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
 hilhdrtghomhdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
 hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
 lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
 gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 gtvghmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kJN2aSIv3Pu0DWq4PlLBY4O9yN-ASCFm0sosaH_aM7i9EA4YDsTCuA>
 <xmx:kJN2abYeSpo0MinYvffT8rAw785eZVBG-PcKAL_iaP1ucQhp7re9OQ>
 <xmx:kJN2aYBSjrpqZHogzuyFxSOU5KPVQuDnSKrscsTWeqY38TyPK1u9Gg>
 <xmx:kJN2aVWy8CkKlf6gkg775B1qrJHTuZBvRHE-xJ4xFo2VZTjC_zlGZA>
 <xmx:kJN2aZ0YOApvQBKMC0QERIDFvmWsvDPu2rt_WQDuXHRp4Iy5hsK3cKSX>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 5D6FA780076; Sun, 25 Jan 2026 17:05:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AdRvsg_UpIrR
Date: Sun, 25 Jan 2026 17:04:28 -0500
To: "Christian Brauner" <brauner@kernel.org>
Message-Id: <a1692040-58d0-412d-b0fc-c7b7a62585c4@app.fastmail.com>
In-Reply-To: <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
 <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com>
 <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
X-Headers-End: 1vk8EL-00035p-L2
Subject: Re: [f2fs-dev] [PATCH v6 00/16] Exposing case folding behavior
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@manguebit.org>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Carlos Maiolino <cem@kernel.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Shyam Prasad N <sprasad@microsoft.com>,
 frank.li@vivo.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, glaubitz@physik.fu-berlin.de,
 Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-nfs@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 Hans de Goede <hansg@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On Sat, Jan 24, 2026, at 7:52 AM, Christian Brauner wrote:
> On Fri, Jan 23, 2026 at 10:39:55AM -0500, Chuck Lever wrote:
>> 
>> 
>> On Fri, Jan 23, 2026, at 7:12 AM, Christian Brauner wrote:
>> >> Series based on v6.19-rc5.
>> >
>> > We're starting to cut it close even with the announced -rc8.
>> > So my current preference would be to wait for the 7.1 merge window.
>> 
>> Hi Christian -
>> 
>> Do you have a preference about continuing to post this series
>> during the merge window? I ask because netdev generally likes
>> a quiet period during the merge window.
>
> It's usually most helpful if people resend after -rc1 is out because
> then I can just pull it without having to worry about merge conflicts.
> But fwiw, I have you series in vfs-7.1.casefolding already. Let me push
> it out so you can see it.

There will be at least one more revision of this series (and it can
happen in a few weeks) to split 1/16 as Darrick requested, and
address the nit that Jan noted.


-- 
Chuck Lever


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
