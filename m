Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F29C27C40
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Nov 2023 20:59:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r5uJw-0002Li-Aq;
	Wed, 22 Nov 2023 20:59:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1r5uJu-0002Lb-Vj
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Nov 2023 20:59:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ItOH4J4akSw10+RJtO1Y4ChxcpuLncLMjxNty1VtDU8=; b=VMvbzH7wenQrS/JzoZf3dUJvx2
 zwwMFn4H+in8X+T/O/zmYJmBCCBsmWeqe0z/aDIv2jrSp4Zi4faJejyeAE1nTdgPfN23Fm0kNO1Lc
 6rQi3frddrJyRurm0HXtvKZ7wt5Jpa24boMqnHwz9G2rLRtHL/JfSdje4eyAlnxr/ris=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ItOH4J4akSw10+RJtO1Y4ChxcpuLncLMjxNty1VtDU8=; b=aZz4jkl3wVc5Cm+yYlOWGoAEYI
 4MIH4Rwi2b1Ea4PTs6O+d9O2IsXrJ+sMRGyqDZXVRfjjdub0pg5/+Jz4qA7LfKPFkAa0kbZWqPjNg
 hVaeEC3GmZni/HFmW73jjOLx9XZGXhExjIHXzIppSG98NM4xoMFBDVQQttP4LL+HqyK4=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r5uJu-00D4Aj-G8 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Nov 2023 20:59:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ItOH4J4akSw10+RJtO1Y4ChxcpuLncLMjxNty1VtDU8=; b=vYv0j7L+dcsY2dIfElCy7D8CHt
 BOJR+U78FSLDhQUShbKI0HjkscG/pNujZ4x7UMH070cOT39LfHRCrOotFD6fZ0eyWVxEwogAYDDsD
 AEZgD3hZNDAzHDTqlsHpFVELRHqBA+heb+41vqvYEnJDOm4aCvXXPR2N0rO+sqIHviTxpM0k4QRLw
 F9Mwy9QPGSXEumvsTjJMKepFcV9zHxQXBHFfcxyDHMlcJWti2YMiNpPPxPRAa6jX4epYmOEUFsa6j
 Tea1pPXz4c65Q5G5aBfSs0dBnfl9N/I+qtWOpvtDpG/TkEa9znfwJsgpUZMVRWIMkLBFh9sbve7LD
 1dQDfBVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1r5uJi-001mWY-2Q; Wed, 22 Nov 2023 20:59:26 +0000
Date: Wed, 22 Nov 2023 20:59:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20231122205926.GH38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20230816050803.15660-4-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230816050803.15660-4-krisman@suse.de>
X-Headers-End: 1r5uJu-00D4Aj-G8
Subject: Re: [f2fs-dev] [PATCH v6 3/9] fs: Expose name under lookup to
 d_revalidate hooks
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
Cc: brauner@kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Aug 16, 2023 at 01:07:57AM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Negative dentries support on case-insensitive ext4/f2fs will require
> access to the name under lookup to ensure it matches the dentry.  This
> adds the information on d_revalidate and updates its implementation.

There's actually one hell of a stronger reason for that particular change;
uses of ->d_name in ->d_revalidate() instances are often racy.

So IMO this is the right way to go, regardless of c-i stuff, except that
it ought to be followed by making individual ->d_revalidate() instances use
the damn argument, now that they have it in stable form.

Said followups don't need to be in the same series, obviously.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
