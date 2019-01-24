From: Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [RFC][PATCH v5 06/09] f2fs: use common file type
 conversion
Date: Thu, 24 Jan 2019 09:27:37 +0000
Message-ID: <20190124092737.GA25629@pathfinder>
References: <20190121005434.GA32358@pathfinder>
 <6f759f75-5906-e499-e86b-a915d714e8c4@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <phil@philpotter.co.uk>) id 1gmbmx-0004Cp-1N
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Jan 2019 09:59:11 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gmbmv-00AHSe-9m
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Jan 2019 09:59:10 +0000
Received: by mail-wm1-f67.google.com with SMTP id y8so2291667wmi.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Jan 2019 01:59:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6f759f75-5906-e499-e86b-a915d714e8c4@huawei.com>
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

On Wed, Jan 23, 2019 at 02:27:34PM +0800, Chao Yu wrote:
> On 2019/1/21 8:54, Phillip Potter wrote:
> > Deduplicate the f2fs file type conversion implementation and remove
> > F2FS_FT_* definitions - file systems that use the same file types
> > as defined by POSIX do not need to define their own versions and can
> > use the common helper functions decared in fs_types.h and implemented
> > in fs_types.c
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
Thank you very much for this.

Regards,
Phil
