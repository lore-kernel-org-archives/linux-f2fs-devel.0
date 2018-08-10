From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: checkpoint disabling
Date: Fri, 10 Aug 2018 16:40:53 +0800
Message-ID: <b156678d-56e6-a46b-c7a6-00f4bc2c4b3d@huawei.com>
References: <20180807234843.129387-1-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807234843.129387-1-drosen@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Daniel,

On 2018/8/8 7:48, Daniel Rosenberg wrote:
> This adds a lightweight non-persistent snapshotting scheme to f2fs.
> 
> To use, mount with the option checkpoint=disable, and to return to
> normal operation, remount with checkpoint=enable. If the filesystem
> is shut down before remounting with checkpoint=enable, it will revert
> back to its apparent state when it was first mounted with
> checkpoint=disable. This is useful for situations where you wish to be
> able to roll back the state of the disk in case of some critical
> failure.

When filesystem is full, statfs shown abnormally as below:

/dev/zram0       2095104 -17177769548 17179864652    - /mnt/f2fs

I guess it's related to this patch, could you have a look at this?

Thanks,
