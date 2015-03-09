From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs:set the correct place of initializing
 *res_page
Date: Mon, 09 Mar 2015 14:50:32 +0800
Message-ID: <000101d05a35$734877c0$59d96740$@samsung.com>
References: <190202356.458601425722862565.JavaMail.weblogic@epmlwas08b>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <190202356.458601425722862565.JavaMail.weblogic@epmlwas08b>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: yuan.mark.zhong@samsung.com, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yuan,

> -----Original Message-----
> From: Yuan Zhong [mailto:yuan.mark.zhong@samsung.com]
> Sent: Saturday, March 07, 2015 6:08 PM
> To: Jaegeuk Kim
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 2/3] f2fs:set the correct place of initializing *res_page
> 
> The function 'find_in_inline_dir()' contain 'res_page'
> as an argument. So, we should initiaize 'res_page' before
> this function.

It is missed by "inline dentry" feature, my bad.
Anyway, it should be corrected for avoiding potential bugs when changing
codes.

Thank you.

> 
> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
