Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE45CD4F3D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zVVxvy2UaoIxZ9TUfTQ39geKAf+N6qe5zFRgP0ooufU=; b=IpbP5Fxgb3F1ZZnTm1bpfL6/Cw
	tsg+SmRtof8REiqoiy+eQhDqV94mfi6L56n2yY9SW2EKn7VMfozhbo1XKNi5bPwDbB5vkDTUYiNMZ
	8YwRCRhROIuGR3cmpldk0SrfxSm/rheA0V7ilPpPhWzl7hb5AdqfbohmyE1+QyChcflI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPkkg-0001l6-4I;
	Wed, 20 May 2026 17:30:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wPkke-0001kz-Vi
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 17:30:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hp/LsSdQ0ID+IBacKCrtn1LiJIpuZ/a/08Y8EBXFu0E=; b=mS10a0LwKhhCZD3jxLOgpY4ecc
 7mcHN/qCytw0rm7u16CKQVNTEV0Hgn+dwBHLCYdB81PK6ko4S9uOlURfT+cuWAHSUfBa1m33fs3lS
 JA4oMcByn0zH/yJF4fqX7P2ur1Gt2eAM2xfnEggT+BHfgqVjbj2q+N9Z/ytiH7QDCwnA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hp/LsSdQ0ID+IBacKCrtn1LiJIpuZ/a/08Y8EBXFu0E=; b=Ma5yJOYuAe5pdHgrBCuvvF6kas
 VTu4pHO4fmP0eGs38Xgvi1KQvyYSzie9t2yk2Mxk9HYhqk8jLwN9EFtiOdD4uAunoFUijHpkGsdWl
 K1jxKFifba5yZALSS4/77eJHd163JmyWqVu733soOVjT3e8tq6wTtkVq5x4vFc8CE3xU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPkkb-000417-5i for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 17:30:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F619401D8;
 Wed, 20 May 2026 17:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDD91F000E9;
 Wed, 20 May 2026 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779298228;
 bh=hp/LsSdQ0ID+IBacKCrtn1LiJIpuZ/a/08Y8EBXFu0E=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=H94sNRNEqRKSUACk8LYK84RxEbL6+b/Vw+285XGry0XSmBqa5aB3J5f6LSMMrm+IP
 58PpB/I1hKpUJgIbjr9vv7xJKdQD6SfZ+05NrAWeoxrrpiru/cRXtAkDA+Asivbbrt
 CJiUjbLwYn0xpzQHMPAQRBk9Cq4jrZymBPkcNm2gAxFE6PY/6uiD+mYwVOLlnwSHgy
 LuPTMQPxf3gp4RhFtO1OdVDrEqQPyP642G9u3yLXTxC1Fx7F4nF6XXYB1fdQDI/R0c
 o70WFXZyDIrzI2cy6AhKtUujqzkLD3wVVcSnEyqvm6g+YsNP6gLyxWUc+UUiYdF9tJ
 q2oR3Fhk9+bMA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 6B958F40075;
 Wed, 20 May 2026 13:30:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Wed, 20 May 2026 13:30:26 -0400
X-ME-Sender: <xms:su8NavFR3K0V9EcvFJfXc3Wsci7E6tZzPh7akBvB6u99zTx8rze7Gw>
 <xme:su8NanI9KFxJAd23rFo4BZcQSSRqZ4IOxvvOi8Hq6e2addjaUtdGgzeW0Snx6bfFV
 F6HZJz8k0LU_FpzJrJko6dN1pLJljMzh_b5Ll8sc0YwUhoSP8OzpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehvdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
 khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
 hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
 hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
 leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
 hilhdrtghomhdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
 hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
 lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
 gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 gsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghmsehkvghrnhgv
 lhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:su8Nas-hLOkDseW56q88vVoEsCdEJofZpbwE6rWAXeInKKpHr_MW5Q>
 <xmx:su8NarAnnqHmefxc4iTmrF4_T-hy_-xQ19oXQWlTGvvmgtwo5lPF1Q>
 <xmx:su8NaoB7yw-Fw6OLeA4_bYVbPfkMLH9YKuPnbxL7dMEJvDRxnu_9gg>
 <xmx:su8Napw2lcPRdf9cLIVzimsPOiNvDq1t578i-dfKLown4ig7XNkDfw>
 <xmx:su8Nanz9yDOkUucI8YkgQgyBNftzdGRtrCi-D4JRFcnETfqVOinIWWHT>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 39DFF780076; Wed, 20 May 2026 13:30:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AuvJ25pICu_N
Date: Wed, 20 May 2026 13:30:06 -0400
To: "Mark Brown" <broonie@kernel.org>
Message-Id: <d2425b45-a37a-4cc9-8984-bed55ee54a32@app.fastmail.com>
In-Reply-To: <cdeaab82-06bf-47c1-8f6c-4e40dbec2344@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
 <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
 <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
 <8b750b3f-4d73-41f3-84fb-6e387fd24168@app.fastmail.com>
 <3a347b64-f91b-450f-b27d-26ea6810b960@sirena.org.uk>
 <858d7233-1d9c-48f4-aa4f-c5a9f6e1f5dc@app.fastmail.com>
 <cdeaab82-06bf-47c1-8f6c-4e40dbec2344@sirena.org.uk>
X-Headers-End: 1wPkkb-000417-5i
Subject: Re: [f2fs-dev] [PATCH v14 03/15] fat: Implement fileattr_get for
 case sensitivity
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
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Shyam Prasad N <sprasad@microsoft.com>,
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Christian Brauner <brauner@kernel.org>, Theodore Tso <tytso@mit.edu>,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, Hans de Goede <hansg@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On Wed, May 20, 2026, at 1:11 PM, Mark Brown wrote:
> On Wed, May 20, 2026 at 12:58:22PM -0400, Chuck Lever wrote:
>> The first option is the narrowest kernel-side change, and
>> matches what other minimal-fileattr filesystems do.
>
> That sounds like a good idea regardless of what we do with the test?

Yes, I have no objection to this approach, but it would be great to
hear from the vfat maintainers/contributors on this one before I
dig in.


-- 
Chuck Lever


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
