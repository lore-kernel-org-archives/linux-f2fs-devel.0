From: Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [RFC][PATCH v3 08/10] f2fs: use common file type
 conversion
Date: Mon, 29 Oct 2018 11:04:59 +0000
Message-ID: <20181029110459.GA13236@pathfinder>
References: <20181027005342.GA9982@pathfinder>
 <d9979cf6-899d-b264-35df-d765e6f0adba@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <phil@philpotter.co.uk>) id 1gH5oV-0002Be-2e
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 11:34:31 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gH5oT-006FKr-Cx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 11:34:31 +0000
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so8275058wru.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Oct 2018 04:34:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d9979cf6-899d-b264-35df-d765e6f0adba@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, amir73il@gmail.com, viro@zeniv.linux.org.uk, linux-f2fs-devel@lists.sourceforge.net

On Mon, Oct 29, 2018 at 06:35:03PM +0800, Chao Yu wrote:
> On 2018/10/27 8:53, Phillip Potter wrote:
> > Deduplicate the f2fs file type conversion implementation - file systems
> > that use the same file types as defined by POSIX do not need to define
> > their own versions and can use the common helper functions decared in
> > fs_types.h and implemented in fs_types.c
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Acked-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
>

Thanks for this, appreciate it :-)

Regards,
Phil
