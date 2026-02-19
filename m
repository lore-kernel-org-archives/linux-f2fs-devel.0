Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2674EE9A048
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39BKOVB5FpUv4KnCzC95sI9+vwIQWxoQJUZinuK6Bu0=; b=PpN2gEiowms1syjpvf/uy0unEv
	yeCSmLLy+Exu7SDYv/jHRJ/PE7sIXV8zcBo58iVGtPMGv/9xLf82wgXHQeEeWlaEOpRUWmKb0KkEa
	mEgdpLiQGKPCJXTTb9H78tWA5UfXtmsmq86KnFAkR+EkWMxx1765NgmG1eI/U9f5AFuw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vt3sM-0005at-DX;
	Thu, 19 Feb 2026 13:15:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1vt3sL-0005al-6n
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Feb 2026 13:15:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YvzVGXRA9tq4Mexi8H81CMjCPQQmDTjjwr0q5r4ZxjY=; b=LKqXicCPlbgolGqerH8PcbMAm+
 FBGzQ8ORsKPwDFlk+nZZVMlfS3JCogbHvx0ScXjTAwpI9jv+7bXLf+sGTe7Cs9WXqHFvvtmo9rOFZ
 sSGyQKk2TdXaxWZSm+pu84Wt9zACQzUjCsfDWD5jC5QAAQ972+u6C43bS/ezmX8VvjpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YvzVGXRA9tq4Mexi8H81CMjCPQQmDTjjwr0q5r4ZxjY=; b=TjuHl3SPFVIGsR7o9kXModvKjC
 lauuRsVu4uOMntMgPJOQB4rkOMlQNjuIndEi3fzOd1HSi++yPyvDKq1kT7v11qpDzphhF5x6MNLaK
 hyZcDIt/BhozpR7cMB7UAQgrq4bZgHb/vdg4fvqisBoK8A7rlGxn7WPrbO4+ZVqY3tRw=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vt3sK-0001dC-Ms for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Feb 2026 13:15:25 +0000
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net
 [173.48.113.47]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61JDEfrH015259
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 08:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1771506893; bh=YvzVGXRA9tq4Mexi8H81CMjCPQQmDTjjwr0q5r4ZxjY=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=QMseGHyhfBaFWPX10hbUsMCruhrhgp9Y/y2cMCXsfRSODON0B5P+fIp1gbQDE498j
 3kKA0mEvpnBkxC4fOP6ZE400XvESf8AzQ8W4hQYtEoVmenggeiuCZAsgDBp1wUb2cT
 X6xiagrW3q1RCtta1iKSfDQKms5OjV5lnfxVAv8Q2AfkIOYoMk37GhEy8mDWLba8oU
 +wzfcZxoHjbivvm4nlALGSOE0Sgx0+Y+qu96lZShmvpLYtEHFmEOzfCJdgvL6N1a6T
 adL+YMa067AgExO/2xBFBiPTBuMQzJwlEaf6kQsPMFWsEHJLIbYxEGHfhvJQevk+z6
 +8ydG6It0w42g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
 id 51D465919577; Thu, 19 Feb 2026 08:14:41 -0500 (EST)
Date: Thu, 19 Feb 2026 08:14:41 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Chuck Lever <cel@kernel.org>
Message-ID: <20260219131441.GA69183@macsyma-wired.lan>
References: <20260217214741.1928576-1-cel@kernel.org>
 <20260217214741.1928576-9-cel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260217214741.1928576-9-cel@kernel.org>
X-Headers-End: 1vt3sK-0001dC-Ms
Subject: Re: [f2fs-dev] [PATCH v8 08/17] ext4: Report case sensitivity in
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
Cc: Jan Kara <jack@suse.cz>, pc@manguebit.org, yuezhang.mo@sony.com,
 cem@kernel.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, sfrench@samba.org,
 slava@dubeyko.com, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 sprasad@microsoft.com, frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Feb 17, 2026 at 04:47:32PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
> flag. ext4 always preserves case at rest.
> 
> Case sensitivity is a per-directory setting in ext4. If the queried
> inode is a casefolded directory, report case-insensitive; otherwise
> report case-sensitive (standard POSIX behavior).
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
