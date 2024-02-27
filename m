Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5316C48BF6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Feb 2024 01:00:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1relq0-0004dj-7t;
	Tue, 27 Feb 2024 01:00:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1relpx-0004dS-QK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Feb 2024 01:00:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jpJE0OCTSHvA3MT6lcfCkT+G69/vthN8Ji3SAz3g+YM=; b=PK/sZr5pX5F9/nw72zwcI0h/Wi
 THpPrSJJywtZILLmTTzGSLPWz7oQRa9NH7JrI5hXP/A6tgq83rgxh8OUHkjTqaYdcqdZGYpxz3LgH
 V8AbJ8mMqqXC7IW/7uELEvy2fHRrVjCu8xJ7TfR5g/j+ZlNiFG47wz8eoZLocuM/mHEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jpJE0OCTSHvA3MT6lcfCkT+G69/vthN8Ji3SAz3g+YM=; b=BF0bZHLydj7uigGbgRr/ly5gn+
 yHFXbJwI0ITS9Up/cNPamgi3+EcEKlv20zh9iq0o8sttHgLSCN66su52YDDioA697m9u6kwW6buyh
 So0MnfVOE7fCUGTtkXUVseXqd4X1V/0C7k1EFmODrB198MsW59IVk7Ne8TwwJLpLGEIE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1relpx-0008Lf-LW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Feb 2024 01:00:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3729261374
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Feb 2024 01:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C750CC433C7;
 Tue, 27 Feb 2024 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708995638;
 bh=rns9tbOCnQ17z7ThR0yXP5WAZXibD6njSBg/+AoGdPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uRpQawtR6DPv/3KJNMTcCRb3IeSI+I+G5VAD7KM+HG2ylj5YIJR3nb+1De2dsfT5E
 FilDgb2KF0FDmdjQGcmuA3HUkv1NtSoRw5GZJJi48hZq4GvyrFDXxulwGPTzI7pYyW
 09ClKZVEoIJZGtgT5HNNGlq8oaoGOcLJo6TPTi+AF+j0jxZgoDnpcxGucauPbOMOjC
 koxfYHatvKTixDwO2Y7mUeM9Ipl6EyoW6nU4F95+xj4i/iQ0HCTC8oaIgOQQL1IeLi
 54PScHjs366BJUdOuSNBnaHKeJlWSDLbBRvjjmzfX/woBFp8gO8mVcfT8luxKbUgTp
 J9OndJDidkCMg==
Date: Mon, 26 Feb 2024 17:00:37 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Zd00NbIAbs99vn4j@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-2-jaegeuk@kernel.org>
 <68e95cb8-9bf5-4849-befc-bbbe8becfd68@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68e95cb8-9bf5-4849-befc-bbbe8becfd68@kernel.org>
X-Headers-End: 1relpx-0008Lf-LW
Subject: Re: [f2fs-dev] [PATCH 2/5] f2fs: fix write pointers all the time
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/26, Chao Yu wrote:
> On 2024/2/24 4:55, Jaegeuk Kim wrote:
> > Even if the roll forward recovery stopped due to any error, we have to fix
> > the write pointers in order to mount the disk from the previous checkpoint.
> 
> Jaegeuk,
> 
> IIUC, we may lost warm node chain once we allocate new section for all logs,
> should we give some notification in log to indicate such condition that
> filesystem doesn't process a full recovery flow?

How about v2 to preserve the error which gives a warnings on roll-forward
recovery?

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/recovery.c | 2 +-
> >   fs/f2fs/super.c    | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index b3baec666afe..8bbecb5f9323 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> >   	 * and the f2fs is not read only, check and fix zoned block devices'
> >   	 * write pointer consistency.
> >   	 */
> > -	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
> > +	if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
> >   			f2fs_sb_has_blkzoned(sbi)) {
> >   		err = f2fs_fix_curseg_write_pointer(sbi);
> >   		if (!err)
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 2e41142d07c0..4d03ce1109ad 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4673,7 +4673,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >   	 * If the f2fs is not readonly and fsync data recovery succeeds,
> >   	 * check zoned block devices' write pointer consistency.
> >   	 */
> > -	if (!err && !f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> > +	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> >   		err = f2fs_check_write_pointer(sbi);
> >   		if (err)
> >   			goto free_meta;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
