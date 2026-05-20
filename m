Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE6DCD5BA4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OH1y0WDSHxDYT3Hfr5rZZoPnstwJ2QdBHAph97Z5hAs=; b=c972zvv22PjEMF7UJxmXc2ZDRK
	yJkmuQZp1h+uP08zUnYWxgFAmpW4e/rrFZsaU5IsFo4ue9Kzqk017VBDW2mwhCipHfwx5UJ/qjZ8M
	k2NW/aMmOzxe8s1ej8Ci5vSvzkrLpt8gzshizXnplaV11J3McPkh1S2740+sNHV+ostQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPkFy-0008Q3-PC;
	Wed, 20 May 2026 16:58:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wPkFx-0008Px-FD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3HYCTjUKnMgOBwx9QLeP6Mvnf90VdQqX6Kq1eV2MzLM=; b=O7652ypcU+qCDGJMEX8CP4S1TV
 5R7ItuZ6HPrDRkl+/W/Q7Yhjm25f8/DsxjyDNAxcDulfGeYhtQmoybfMqA2PL0S1K7JKoaU6Iq817
 b06rPvBG79DkJD0n+l2myscbL3OLOxgj39txCc1EOSnsIJTd4ot+9e+zHb0fo8R6OeKA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3HYCTjUKnMgOBwx9QLeP6Mvnf90VdQqX6Kq1eV2MzLM=; b=f8xVJRi7k1hv12GiVhyOKkzKbc
 hGzRgrdyfkLKvms9b8OY+n6KSk1fr142aVMG1XbBvoibWh8+bwcJzyRsmAgHj32zXlYfy78NIfj6q
 BNP+lxAS5hqNttVWXSsmo2XP40hxinlDw4v6l3GjM8QNc9+NLoFLxciHtYu7shIBLzMA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPkFt-00029U-RB for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:58:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EBA560139;
 Wed, 20 May 2026 16:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0611F00893;
 Wed, 20 May 2026 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779296324;
 bh=3HYCTjUKnMgOBwx9QLeP6Mvnf90VdQqX6Kq1eV2MzLM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=UwbdSUFfiPD5nEs75u3836d9xkPyk26dXYEF4j6ngljmJB9byL9nvxBvogPMZEwS4
 HlmwR0Rq34lWaUCSaxX+qP0G3jQY+n5dNstgtVC1XjtFLnN6eag316xOeo21Oo3l8g
 nI/CHm5zH75HQblS72L7CFw3OiTnVKVi2i56AqGT074yhwFoulv9ggS7h9og71NL8s
 CUImdcg29FH5HSElh25NizNdrsqsSlyqKLhIH/aZ9mRzSL8VNxnMhU9kQHBMXoWC96
 wXpf0wB09Xs4FpEjOOUxXPlqI+hwRYphh5mtId442ujsKT5lIzZRLejcS2h5i3exxx
 +yDZS5cE5w3vg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 653BFF4007D;
 Wed, 20 May 2026 12:58:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Wed, 20 May 2026 12:58:42 -0400
X-ME-Sender: <xms:QugNavyinx7bKrqL4HPeQunpcXbIaluZN7wF9StWTZXgR2qve6JZ-g>
 <xme:QugNaiGhRRos_yOLWfm-5tiI1PIm-uXq5yDDMT3oiNGBSfN1wx_UeyhKOJHGIa_bo
 cQ9rqE22bExtjIDyUHyrxhoLANTG9qDp37GvGe2tAPk0XVFu3TxC64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehudejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QugNamfaq2UpdXiWnPnay5nQ_rQckvm_41kR8NgaI4_lDDqQ4Yiy8A>
 <xmx:QugNamv95ErjE6pb8okHjc44uM5BHK6ky05NPxz2-vrTiBeWgMpiJw>
 <xmx:QugNaqupzmbSbdKQTrJcjN0dK0NknGvcRa4HhfzOtsthEH7eWtONFQ>
 <xmx:QugNat90cmRSntFhphxoUhXn78eiEA_yq5VNO1np6BiZmUQI6kUYVw>
 <xmx:QugNar9VQVV9Crz_mdTjuEL665Y3HC3jfH6afIH-rv2ZfQMjW6d6XLfr>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 33FD9780076; Wed, 20 May 2026 12:58:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AuvJ25pICu_N
Date: Wed, 20 May 2026 12:58:22 -0400
To: "Mark Brown" <broonie@kernel.org>
Message-Id: <858d7233-1d9c-48f4-aa4f-c5a9f6e1f5dc@app.fastmail.com>
In-Reply-To: <3a347b64-f91b-450f-b27d-26ea6810b960@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
 <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
 <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
 <8b750b3f-4d73-41f3-84fb-6e387fd24168@app.fastmail.com>
 <3a347b64-f91b-450f-b27d-26ea6810b960@sirena.org.uk>
X-Headers-End: 1wPkFt-00029U-RB
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


On Wed, May 20, 2026, at 11:19 AM, Mark Brown wrote:
> On Wed, May 20, 2026 at 11:12:51AM -0400, Chuck Lever wrote:
>> On Wed, May 20, 2026, at 10:54 AM, Mark Brown wrote:
>
>> > It's not testing tmpfs (well, it does but that passed), as the log above
>> > shows it is making a vfat filesystem on a loop device backed by a file
>> > that happens to be in a tmpfs and then testing that.  There's a bunch of
>> > filesystems covered in this manner:
>
>> OK. Is vfat the only failure in LTP statx04 ?
>
> Yes, it's the only one showing as failing - there are four failures
> correspoding to the four tests done for vfat.

03/15 adds .fileattr_get = fat_fileattr_get for both
fat_file_inode_operations and vfat_dir_inode_operations. LTP
opens a directory (SAFE_OPEN(TESTDIR, O_RDONLY|O_DIRECTORY)),
so FS_IOC_GETFLAGS on the dir now succeeds, and statx04
proceeds where it was previously skipped.

AFAICS, 03/15 did not change pre-existing kernel behavior of
stx_attributes_mask on vfat. It merely converted a "skipped"
LTP outcome into an "executed but failed" outcome.

Fix options:

* fat_getattr() could call generic_fill_statx_attr(inode, stat),
  which advertises KSTAT_ATTR_VFS_FLAGS (IMMUTABLE + APPEND).
  That clears 2 of 4 TFAILs but not COMPRESSED/NODUMP, which
  FAT genuinely does not back.

* Set stat->attributes_mask |= KSTAT_ATTR_FS_IOC_FLAGS in
  fat_getattr(). Honest only to the extent that FAT now exposes
  some FS_*_FL bits via fileattr. This would silence the test
  failures, but advertises capabilities (COMPRESSED, NODUMP)
  FAT doesn't track.

* Admit the LTP statx04 test needs to be updated.
  FS_IOC_GETFLAGS succeeding does not logically imply all four
  FS_IOC_FLAGS-mapped STATX_ATTR_* bits are supported. The
  test's gate is too coarse for filesystems that gained a
  narrowly-scoped fileattr_get (just casefold/immutable). The
  test's tag list pins it to filesystems that do support the
  full set, but vfat was tacitly excluded by the prior ENOTTY.

The first option is the narrowest kernel-side change, and
matches what other minimal-fileattr filesystems do.


-- 
Chuck Lever


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
