Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F33FD74EF2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6AkQZdxUDFcJ+SKLoLYtWRqlP6YUyQfN6YD2UQsvckE=; b=U03d/S87O+rBLpX+USMY8ci3xQ
	A8R4wYqRPTdCHwElonsf010MVP7jcpSlvaP6f3GUeBmqcpL4XseJ6Y+InwlW5JhyYDD6rmGKxJqXo
	pnJVe6cSbMTlMKhpKsBCgpcdDKPpQ7c3BeGwphBnVFhxgMUApVPY3wWO3Unlxv+/T/vg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjJQL-0003TW-Ja;
	Fri, 23 Jan 2026 15:50:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vjJQJ-0003TF-Hi
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 15:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BzppY9XZyJmB3FJfXdpLIJg4O0Qh4h2HcU5B3a92Z0k=; b=ZwRFwknqUTG3bGgx5j2lCoNHnq
 4/ygHqJ2cPu6AVGI+s/vm0gPASdZEtWqKxPxKzAJ5X6s1hFHeO+kDE158gwNiNBovDESMIp4Ymm7K
 zMCEeJ7MDWdezkZ3oaO5XBWsBIWXMWCuLEl2Af7bdCSsD7j/ySkzlpbFT3BnW9jble4M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BzppY9XZyJmB3FJfXdpLIJg4O0Qh4h2HcU5B3a92Z0k=; b=F1tNNuEWYXxvoGuC6vf0J/O9Eu
 BEBazoz83GE3HhQ/gIms0uWG+dri4Q44h+GqD97m9kv50aUM1YakgQNtNQditN37yhor3Lo36jfMd
 MZQq8p7LR8IWKnN1Ob+RL+p4bS/2zuoXreaKbqz/2Czjo4YtvxcI/5QHLs5cYOQNmEGU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjJQI-0002pH-Tz for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 15:50:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 40B1F6012B;
 Fri, 23 Jan 2026 15:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268FAC4CEF1;
 Fri, 23 Jan 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769183405;
 bh=kDP9Yb3CbfggR8X+hWoqLQMPd20AumtY0Il/c8TNaKY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Oe08t/o/2NDsUrMKUH1M6DPGJM2ZN7cDoW08+cOE4juSlAGvrXORrSwCclCZw2aDV
 ZkVTKgFOWWiO1/7UD1FizCrSF5aPkbMt0Xz4yP7v5wFhzCq1Ehfu3cawiSSiJn4aFe
 tMl2S1/Ku9JhhGFB7uQXeL5ZqG6ZVdbkqwNvLCmPFT6cK/SRjDjHv08QbhhTdsOSlg
 YMufXMi1X8phtUbamkl5WfuMZM1sjX7V2NmsZD7t/TCp+rOJJNc02MHDzBzX/GOr5L
 jR8J1YHTCxnnSmEGS1fVMkvtoFxQA5PdCm3odBjzpdLrYydUjdPpPGZlr8mqEYL1Up
 hVo8FmzWqbd9w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 0A23CF40068;
 Fri, 23 Jan 2026 10:50:03 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 10:50:03 -0500
X-ME-Sender: <xms:qphzaYMIDusB_Xk8Iw4J_qqx-jkUaULhjU_4qBqzWqUpKgNdpST7Cg>
 <xme:qphzaZwl8v4sf68uioXcKj_hJesszvmBEUsFWRFNXVrVwnqNhC5YZvqLhTM2T-XL_
 29Ydjf5oRad8fHsuBJog-RE6knXPauD3N-ITfWRSm2Ph-WFBMqAALk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelgeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
 khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
 hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
 hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
 leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
 hilhdrtghomhdpnhgspghrtghpthhtohepfeefpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
 hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
 lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
 gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 gtvghmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qphzaSbprTumlZMvqgi-fN0ySmTrpZ1Sy0mhtQX_uK9_de-fQjcsIQ>
 <xmx:qphzacPOrC9HHyrIfATDQn96t02Xea-4bAtCO00lX8l1ixs2IPp1Qg>
 <xmx:qphzaV7RqCEgahzQH87IyqIo3vInECWRwzjRgOBG54mM8UGQ7ppphw>
 <xmx:qphzaXdkpZ-ujvs4OTjQ3zL-M4ps1358Ma37t8lfmfNwKytySSzPTw>
 <xmx:q5hzaR40E4HhwCPyJxnEpYdnMVQu5gKh2EFfpqDTxHOkz4PYOS4LUXhO>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id D0B1A780075; Fri, 23 Jan 2026 10:50:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AX_vFn8fWldV
Date: Fri, 23 Jan 2026 10:49:38 -0500
To: "Darrick J. Wong" <djwong@kernel.org>
Message-Id: <95aa2a65-e1e8-44ef-a62a-e3190a11cb32@app.fastmail.com>
In-Reply-To: <20260123002904.GM5945@frogsfrogsfrogs>
References: <20260122160311.1117669-1-cel@kernel.org>
 <20260122160311.1117669-8-cel@kernel.org>
 <20260123002904.GM5945@frogsfrogsfrogs>
X-Headers-End: 1vjJQI-0002pH-Tz
Subject: Re: [f2fs-dev] [PATCH v7 07/16] ext4: Report case sensitivity in
 fileattr_get
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
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, glaubitz@physik.fu-berlin.de,
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



On Thu, Jan 22, 2026, at 7:29 PM, Darrick J. Wong wrote:
> On Thu, Jan 22, 2026 at 11:03:02AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
>> flag. ext4 always preserves case at rest.
>> 
>> Case sensitivity is a per-directory setting in ext4. If the queried
>> inode is a casefolded directory, report case-insensitive; otherwise
>> report case-sensitive (standard POSIX behavior).
>> 
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/ext4/ioctl.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
>> index 7ce0fc40aec2..462da7aadc80 100644
>> --- a/fs/ext4/ioctl.c
>> +++ b/fs/ext4/ioctl.c
>> @@ -996,6 +996,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>>  	if (ext4_has_feature_project(inode->i_sb))
>>  		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
>>  
>> +	/*
>> +	 * Case folding is a directory attribute in ext4. Set FS_XFLAG_CASEFOLD
>> +	 * for directories with the casefold attribute; all other inodes use
>> +	 * standard case-sensitive semantics.
>> +	 */
>> +	if (IS_CASEFOLDED(inode))
>> +		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
>
> Curious.  Shouldn't the VFS set FS_XFLAG_CASEFOLD if the VFS casefolding
> flag is set?
>
> OTOH, there are more filesystems that apparently support casefolding
> (given the size of this patchset) than actually set S_CASEFOLD.  I think
> I'm ignorant of something here...

I'm not clear if there's a review action needed. Help?


-- 
Chuck Lever


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
