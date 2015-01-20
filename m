From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [RFC PATCH 01/10] f2fs: move ext_lock out of struct
 extent_info
Date: Tue, 20 Jan 2015 16:30:50 +0800
Message-ID: <008501d0348b$a52b4800$ef81d800$@samsung.com>
References: <000501d02e36$ba5070d0$2ef15270$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000501d02e36$ba5070d0$2ef15270$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Ping, any comments on this RFC patch set?

Thanks,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Monday, January 12, 2015 3:09 PM
> To: Jaegeuk Kim; Changman Lee
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [RFC PATCH 01/10] f2fs: move ext_lock out of struct extent_info
> 
> Move ext_lock out of struct extent_info, then in the following patches we can
> use variables with struct extent_info type as a parameter to pass pure data.
> 
